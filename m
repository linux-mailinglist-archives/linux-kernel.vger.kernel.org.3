Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5695B2A97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIHXus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIHXud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:50:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F840E228E;
        Thu,  8 Sep 2022 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ygZst2c8E+5DGMBVgu2dq0PiJMOgR/bTJgZJoux/5hA=; b=BBWvub0Y3d22S6VU6LfUV/St9O
        vx7GiohaeWpTpb9TvnAE3fwAlV20Xbgt4cDmgOEKTGEcNxeN997+4np4P85ky7dIw6qSvhqIgLeR1
        YRc/KtJ8K2et7aZPESs1EKUGagsByqfS1IVflmDGZPVuBwkw77wgtKLH1fs6IFzkxIQmA+foadslB
        39enyPA35QZ49aWPy+Kb6a0R1+5yaRq7TGSeiWLKdXmxPtRfoNzmEl1YNWYG2My/8Tdto3dzxRUM1
        fpPnrnbyaCGh7ccsqdpOQyZ2gjzJWREAeZW57q3yHh6gLl+iTIjRScaim3dlQpaGB8G+LwVl1DhC+
        WEF3DGlg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWRHw-009xQ2-Rt; Thu, 08 Sep 2022 23:50:28 +0000
Date:   Thu, 8 Sep 2022 16:50:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     petr.pavlu@suse.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [PATCH v2 modules-next 0/1] module: Add debugfs interface to
 view unloaded tainted modules
Message-ID: <Yxp/xIRT9q2J+cUN@bombadil.infradead.org>
References: <20220901152454.2394228-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901152454.2394228-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:24:53PM +0100, Aaron Tomlin wrote:
> Hi Luis,
> 
> Changes since v1 [1]:
> 
>   - Replaced the use of module_mutex to instead mark
>     a RCU read-side critical section (Petr Pavlu)
>   - Added __acquires() and __releases() to support
>     sparse context checking
> 
> [1]: https://lore.kernel.org/lkml/20220823193225.2072649-1-atomlin@redhat.com/

Queued up to modules-testing, thanks!

  Luis
