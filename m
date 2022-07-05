Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8A566848
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiGEKlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiGEKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6427215730;
        Tue,  5 Jul 2022 03:40:44 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fz0-0002Jv-02; Tue, 05 Jul 2022 12:40:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 04C64C0230; Tue,  5 Jul 2022 12:23:29 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:23:28 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/mips to MIPS
Message-ID: <20220705102328.GF9951@alpha.franken.de>
References: <20220613121408.8786-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613121408.8786-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:14:08PM +0200, Lukas Bulwahn wrote:
> Maintainers of the directory Documentation/devicetree/bindings/mips
> are also the maintainers of the corresponding directory
> include/dt-bindings/mips.
> 
> Add the file entry for include/dt-bindings/mips to the appropriate
> section in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Thomas, please pick this MAINTAINERS addition to your section.
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b30f6b69477..6bf0c0ff935f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13362,6 +13362,7 @@ F:	Documentation/devicetree/bindings/mips/
>  F:	Documentation/mips/
>  F:	arch/mips/
>  F:	drivers/platform/mips/
> +F:	include/dt-bindings/mips/
>  
>  MIPS BOSTON DEVELOPMENT BOARD
>  M:	Paul Burton <paulburton@kernel.org>
> -- 
> 2.17.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
