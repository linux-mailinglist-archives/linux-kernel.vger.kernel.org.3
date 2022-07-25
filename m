Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F11157F7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 02:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiGYA7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 20:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYA7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 20:59:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5986DFF6;
        Sun, 24 Jul 2022 17:59:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bf13so8960138pgb.11;
        Sun, 24 Jul 2022 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GeXl5GSyAbSItPm6ihIZlzdvz0QHtuVM/OL9U7toiKc=;
        b=DaISG9dn/8fH2Yf83eWjYAA6w/M8YXfUd1TMJ9aWYrdUd8VKm8ndp+ymzpErMVyXhG
         kSWqIyt2Tpz02nXpcPOb+tUAnV+OGa8mmgPksPcX4bggNNb9Rqz7rdEZlgrsUoj4nOka
         +tq6WpV/w3j8xuNp0Yu2WjF885kKj60uuX1LtGfVsCDRuIbb95ykMmGyV1CUjNV6Yho6
         aL8NRulySDj2bXBBU3XyCogt18Pii3exd+ZkHDaE2vsVrO+zM0MXsaGWMTDCiHe6v+Q8
         wohf09oiwVYH4uGfGesjeGCgd09ZTLZxne4/Ei43P7LXgQNGwrz7oZ9CZsjIWiCPs6yq
         OP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GeXl5GSyAbSItPm6ihIZlzdvz0QHtuVM/OL9U7toiKc=;
        b=4HibIdPceaE58CeZVTI2W3B9+Ap61psjOKZ7jBcQXmPy1oUchpK7W0WnYYaW+SVvxS
         wPfr15dbgnv3jbbouIQtKIsKevI1yYtkXT7EDWog8my/ZLIxK21mZC9uwa5e4Cv+aGjb
         b4BUSb5FOjSd3UmQCMRzeRi0K/+Plv5SNHmqVg0RonAUEnpkZnnTfW1jqoQV/vNUuFnA
         hFvFEmS869FRjtS4gJ3kmyVhLPEOZoMpmAyyRi4JizDrqOjh3GLGWtXJlVhZpHgLNlPr
         JgxS0lE8eE1aIWEtpWnRUi6ZwaRBpXOgPEd3241qwljLh2iHri9LzdwuJP+a2S3IhWwA
         Sicw==
X-Gm-Message-State: AJIora/BkGPGHeK8Rrq762wjv8Zau48wywhJn858YvIWmIWhpiwjTbE1
        7Ku82m35VU9iU9IxwO1++RA=
X-Google-Smtp-Source: AGRyM1tt8kRa9ipdbWAhkxHfcq/bCyqpx1QoKe5athWoxm6BQzsgFTxc39Nrn3GrxES05K+BeCXZuQ==
X-Received: by 2002:a05:6a00:150d:b0:52b:1ffb:503c with SMTP id q13-20020a056a00150d00b0052b1ffb503cmr10478689pfu.44.1658710746682;
        Sun, 24 Jul 2022 17:59:06 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902a51400b001620960f1dfsm7724997plq.198.2022.07.24.17.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 17:59:06 -0700 (PDT)
Date:   Mon, 25 Jul 2022 09:59:04 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: linux-next: manual merge of the pci tree with the risc-v tree
Message-ID: <Yt3q2LX4ds9lwXW+@antec>
References: <20220725102221.20fe2ca2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725102221.20fe2ca2@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:22:21AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pci tree got a conflict in:
> 
>   arch/riscv/include/asm/pci.h
> 
> between commit:
> 
>   bb356ddb78b2 ("RISC-V: PCI: Avoid handing out address 0 to devices")
> 
> from the risc-v tree and commit:
> 
>   a2912b45b082 ("asm-generic: Add new pci.h and use it")
> 
> from the pci tree.

Hi Stephen,

We had anticipated this and I believe Palmer should be merging the pci changes
to his branch to resolve the merge conflict before sending the changes upstream.


> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/riscv/include/asm/pci.h
> index 830ac621dbbc,6ef4a1426194..000000000000
> --- a/arch/riscv/include/asm/pci.h
> +++ b/arch/riscv/include/asm/pci.h
> @@@ -12,31 -12,7 +12,10 @@@
>   
>   #include <asm/io.h>
>   
>  +#define PCIBIOS_MIN_IO		4
>  +#define PCIBIOS_MIN_MEM		16
>  +
> - /* RISC-V shim does not initialize PCI bus */
> - #define pcibios_assign_all_busses() 1
> - 
> - #define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
> - 
> - extern int isa_dma_bridge_buggy;
> - 
> - #ifdef CONFIG_PCI
> - static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> - {
> - 	/* no legacy IRQ on risc-v */
> - 	return -ENODEV;
> - }
> - 
> - static inline int pci_proc_domain(struct pci_bus *bus)
> - {
> - 	/* always show the domain in /proc */
> - 	return 1;
> - }
> - 
> - #ifdef	CONFIG_NUMA
> - 
> + #if defined(CONFIG_PCI) && defined(CONFIG_NUMA)
>   static inline int pcibus_to_node(struct pci_bus *bus)
>   {
>   	return dev_to_node(&bus->dev);

Your conflict resolution patch looks good to me.

-Stafford


