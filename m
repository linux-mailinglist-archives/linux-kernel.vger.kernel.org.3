Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9B550C78
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiFSSLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 14:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFSSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 14:11:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB8F630D;
        Sun, 19 Jun 2022 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Pf+/bzAlHO/VrwENCvse1zb98qX5FPX+pGZeFKAOgTA=; b=aAOhZeAxKogvb6thHN54MHf00x
        IivC5jM+WxnmYZiHxLNPFdc8v6jL7XBgxWidfluMa5Zqzwyg82iHOuTibV4eF36DGQSBlUABEjDw1
        aI/DKtEpw8prID48k5UY8i4qvkLqtYJ9Eg/QEdZuuuN9v6n5k3auVDdEh4AAtDiHv7LQ2hXmvVVRs
        KmKHONJM/uf1jLwVAjitySk38spVQuF2xmm43zgRI8zxcWLg06+wu0rkUhgx4YAKLOL+wn5ItFeOu
        x9G+7B2WYM1sZ0FU9q9ywea1KCzamcNHGhjE69Ohl1qKfrewKEj54uyXf6yyT/vIlcTtBUk4Q4wuj
        +DdmNQXA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2zOW-004WgE-PS; Sun, 19 Jun 2022 18:11:33 +0000
Message-ID: <8a4828ca-5eb4-45a6-bcf1-d9ad7cfcf2af@infradead.org>
Date:   Sun, 19 Jun 2022 11:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MIPS: PCI: Remove leading space in info message
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220619174326.28743-1-colin.i.king@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220619174326.28743-1-colin.i.king@gmail.com>
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

Hi,

On 6/19/22 10:43, Colin Ian King wrote:
> There is an info message with an extraneous leading space. Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/mips/pci/fixup-lemote2f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
> index 632ff2daa338..790d674cd80a 100644
> --- a/arch/mips/pci/fixup-lemote2f.c
> +++ b/arch/mips/pci/fixup-lemote2f.c
> @@ -80,7 +80,7 @@ int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  		}
>  		return dev->irq;
>  	} else {
> -		printk(KERN_INFO " strange pci slot number.\n");
> +		printk(KERN_INFO "strange pci slot number.\n");

Preferably	                          PCI

>  		return 0;
>  	}
>  }

-- 
~Randy
