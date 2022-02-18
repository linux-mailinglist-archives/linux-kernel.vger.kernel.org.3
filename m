Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED04BB410
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiBRIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:22:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBRIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:22:30 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5C633DA55;
        Fri, 18 Feb 2022 00:22:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 91CE080AF;
        Fri, 18 Feb 2022 08:21:29 +0000 (UTC)
Date:   Fri, 18 Feb 2022 10:22:12 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [BUG]: musb broken since v5.17-rc1 on gta04 (omap3 / dm3730) -
 cf081d009c44 ("usb: musb: Set the DT node on the child device")
Message-ID: <Yg9XNBlOtwBamDm/@atomide.com>
References: <F24D461D-8103-456E-AD28-1AA9D5C2AA3D@goldelico.com>
 <D26EF7C8-5264-456F-88FC-1B55AB83AAED@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D26EF7C8-5264-456F-88FC-1B55AB83AAED@goldelico.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [220215 06:40]:
> Hi Rob or Tony,
> any insights or fixes?
> 
> At the moment we have simply reverted cf081d009c44 in the Letux distro kernels.

Yeah this probably should be reverted unless Rob has better solution
available.

Regards,

Tony
