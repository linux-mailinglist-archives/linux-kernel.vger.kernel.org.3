Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2095514DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiFTJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbiFTJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:51:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF09D13E00;
        Mon, 20 Jun 2022 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655718692; x=1687254692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wKG3yHDY3jxND3pnewROmPbZC+Yuv0XTwko/EEp6Uag=;
  b=VoGd6zrdzx5gucdDdUa1kNPDwA9XDGvdniC5+chyWID4dxmRWv6Wg3qG
   N1A5F9SP8MGW6DzQEynSK4oo3iw3kmsPgPQrQONuZnvfJk0UBfPt+xY56
   b0bJyK99j6suDqAtsHA301eNViLxesrGU2s49SZd8hPrh4unqODlCEF18
   PxyLPpbUcmAJk+BFyGfSIJBrYioYML5mlxAhXsa1591e3L7ukZ9BwGXdW
   jqxC9/53e/Duy/CCqCCt3YTLRnT+QmK/0DHRoOGcb/ev+hi0SV7ItUVBG
   9yggTtxZed4d4U8skcpgRLA0IRVK+rRYXxKQOU9+FVTyU/eANWAKOSI92
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277401919"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277401919"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:51:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833039096"
Received: from gna-nuc-dev34.igk.intel.com ([10.102.80.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:51:16 -0700
From:   maciej.kwapulinski@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, corbet@lwn.net,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        guy.zadicario@intel.com, linus.walleij@linaro.org, olof@lixom.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, maciej.kwapulinski@linux.intel.com
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
Date:   Mon, 20 Jun 2022 11:49:07 +0200
Message-Id: <20220620094907.4101274-1-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <85a6nq45uh.fsf@linux.intel.com>
References: <85a6nq45uh.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 09:38:14 +0200, Maciej Kwapulinski wrote:
> after consulting, we will try to share api and some kernel code
> between the two drivers.

We prepared a prototype work based on Daniel Vetter’s invitation to
evaluate DRM framework as prospective fit.

Early results look quite promising. Effective leverage of DRM framework for
non GPU driver has been achieved. GNA driver source code turned out to have
been simplified by offloading some areas (device management + memory
regions management).

As a result, GNA driver source code size has been reduced by 15% (420
lines). DRM Framework complexity has not been an issue so far.
 
Plan for next step is to publish code to dri-devel ML.
Please share your thoughts.
 
Regards,
Maciej
