Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A83554D05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358370AbiFVO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358474AbiFVO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9BF2CC82;
        Wed, 22 Jun 2022 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Q+GTgV1Myt9PfoB6iV4UxseRxbapfjpXe+rtPY77PCI=; b=tyaa/dkVMyBsD6vkyFVEEv23MS
        zo+cEx1xYRceiEVyKiQ8P6GRD6r1OBMuWYAmcWHgXZsnkIDYzKE8Z+E6TPn41MT8VHR4cRELd4Zw3
        /Lj0zcNglNEFVb35/8JZ4bXdfWLlvj6voLwu0c97nFsb2OQOzeK4i0c5ys9K7sEtrWPX2F9p9rWKK
        dwKcpIBO6TfzEM/luJy+LNReAfCmgMeE9kPg22exGmIIYLY+mf6h6fsETWFbR2636T2YCsVwMngLT
        D/MzRWNhfJcayPOKyyeVOb1YMnUsnrTnUHK/6wKr/aQnyyV8b1fMX161fWxH3oo06tZy2Rb/Yvgvi
        IeqLn85A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o41LS-00741h-3X; Wed, 22 Jun 2022 14:28:38 +0000
Message-ID: <d2112863-bd28-d6db-c353-1b7b94b45fcb@infradead.org>
Date:   Wed, 22 Jun 2022 07:28:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MIPS: Fix 2 typos
Content-Language: en-US
To:     Zhang Jiaming <jiaming@nfschina.com>, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
References: <20220622090713.24370-1-jiaming@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220622090713.24370-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/22 02:07, Zhang Jiaming wrote:
> Change 'modifed' to 'modified'.
> Change 'relys' to 'relays'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 1daa0c6b6f4e..82c51f015ea3 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> @@ -282,9 +282,9 @@ union cvmx_helper_link_info __cvmx_helper_board_link_get(int ipd_port)
>   * support and should return the number of actual ports on the
>   * board.
>   *
> - * This function must be modifed for every new Octeon board.
> + * This function must be modified for every new Octeon board.
>   * Internally it uses switch statements based on the cvmx_sysinfo
> - * data to determine board types and revisions. It relys on the

                                                      relies

But it would be better to restrict this barrage (or swarm) of patches
to Kconfig help text problems and/or strings that are printed to users.

> + * data to determine board types and revisions. It relays on the
>   * fact that every Octeon board receives a unique board type
>   * enumeration from the bootloader.
>   *

-- 
~Randy
