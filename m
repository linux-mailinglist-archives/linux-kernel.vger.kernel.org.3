Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5743C4AF426
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiBIOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiBIOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:32:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C879DC06157B;
        Wed,  9 Feb 2022 06:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644417158; x=1675953158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kl4uerH/IdBX/mJpaEpcsoQr9HonqgWmsJKYirrL0UU=;
  b=DFifMCr7kdmVeVtQCEwAqp6INvLp4+xvkV4JT2sq/9ao6sWRJ3QVuOmQ
   tA/W5AJmjIvB+2zgMDmH06GxXvRmwAONKhpPaE3bUtbjVPrTU8wVk/iU5
   BAPYna/HEFjcNInHVbxMkmi10Np4kkkuaspQltotQ7Fk35VH/KOkA38cU
   CZ/hEKovWqW0CIVXivBfprEIX8d1nJeTt52SzpMBkpgCW9ZD/LZ/W9pZP
   ztSUXsSYtUPwqPl/nHl2f2WWSdflG+KZNOfaZoqkOwzMwVZ1d5PmnsHf1
   ERSOmOV1R4P9505Cdb7pUKA0p4rjaYuFN9f7xy7lk7w3/5fMxJ08TOJ7t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249164215"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="249164215"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678609770"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 06:32:35 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 16:32:34 +0200
Date:   Wed, 9 Feb 2022 16:32:34 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        cy_huang@richtek.com, will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add Richtek RT1719 USBPD controller support
Message-ID: <YgPQgtcO22W3vZDw@kuha.fi.intel.com>
References: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
 <YgPOz6pfpFcPmHms@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPOz6pfpFcPmHms@kroah.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:25:19PM +0100, Greg KH wrote:
> On Wed, Feb 09, 2022 at 10:02:33PM +0800, cy_huang wrote:
> > 3. Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
> 
> Why?  Either is fine, any specific reason you changed this?

Because I proposed it. I believe everything scripts/checkpatch.pl
tells me.

thanks,

-- 
heikki
