Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7400F56575C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiGDNc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGDNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D611A00;
        Mon,  4 Jul 2022 06:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3CB614FE;
        Mon,  4 Jul 2022 13:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539A5C3411E;
        Mon,  4 Jul 2022 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656941331;
        bh=XIwtnQ6NKPC0BfotMk1G0wnhG2C7UeF+3OA9DWRZ//g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcT4komz/hxh0ygo8sCYDhSPVVT+eRWQ/66Fml13ZZRD+jR8ATYL53Xe9E4Y5tpY1
         uUqmREr/LbnFrqaEb2ZHAuQin+nuCUur3GirmiUpaYuyYXzIoHO/TBQFKaFYOY+NfL
         uVhllpZSmwdH2pvxKJaGdA1x4VUjdro8CUiZvUZ8=
Date:   Mon, 4 Jul 2022 15:27:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        xuqiang36@huawei.com
Subject: Re: [PATCH -next] staging: r8188eu: use 'is_zero_ether_addr' to
 identify an empty address
Message-ID: <YsLqpSGHoehauWjs@kroah.com>
References: <20220704123140.100128-1-zhangzekun11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704123140.100128-1-zhangzekun11@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 12:31:40PM +0000, Zhang Zekun wrote:
> Use 'is_zero_ether_addr' to identify an empty ethernet address, intead
> of using 'memcpy' directly.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>

I am now just going to ignore all patch submissions with this line in it
based on a total lack of responses by the developers using it.  See
https://lore.kernel.org/r/Yr7DQJTPrSWTOa0c@kroah.com for why.

greg k-h
