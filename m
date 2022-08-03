Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070855886C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiHCFer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiHCFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1F3DBE5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB41612CB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC9CC433D6;
        Wed,  3 Aug 2022 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659504882;
        bh=gvOhqDEF7m4DAkElOFiSOnNz7nt7H020/Hy4snQZ/UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltfvSPrcGr8lyplG5tQcsDADz7Vh8ZsYIBx2tC53NfW6cFF+G1DNEQN1F+6uD4+xo
         Ff+jocTBfo5IdYPKhDiSw8u7nrM6khe7Wp9io26tE1Axxsg0LWbgTmyM9zdhynFr8d
         wAsGV+bxDaASKT9h2+vjJ/YRFebOQm1GgyF4Rebw=
Date:   Wed, 3 Aug 2022 07:34:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yuji2.ishikawa@toshiba.co.jp
Cc:     ogabbay@kernel.org, jiho.chu@samsung.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: New subsystem for acceleration devices
Message-ID: <YuoI7dUe9UexgEIm@kroah.com>
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <YuahxB6geST6ZtGN@kroah.com>
 <TYAPR01MB62013A228CD094847524F8D8929A9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <CAFCwf139nRjebnMfHPuhHWBh_6pWuRm=9sBjgAFL9u9GsOqEzw@mail.gmail.com>
 <TYAPR01MB620151C7322BCC174266FA2C929C9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB620151C7322BCC174266FA2C929C9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 04:39:12AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> Visconti DSP driver might be interesting for you as it provides multiple functions and requires external firmware.
> The problem is that I don't have official public repository. 
> I wonder if it's possible to post some pieces of code to this ML.

You can always post code to this mailing list, that's what it is here
for!  :)
