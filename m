Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A90585A55
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 13:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiG3L6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 07:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiG3L62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 07:58:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920427FC2;
        Sat, 30 Jul 2022 04:58:25 -0700 (PDT)
Received: from mail-ej1-f52.google.com ([209.85.218.52]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Myb09-1nWMa23t4X-00yzje; Sat, 30 Jul 2022 13:58:23 +0200
Received: by mail-ej1-f52.google.com with SMTP id os14so12589171ejb.4;
        Sat, 30 Jul 2022 04:58:23 -0700 (PDT)
X-Gm-Message-State: AJIora8V8G6AQK/3isvSN9H8arjxzdkSybJuis4c7Y/rbX+h3JEYP2HL
        awsXbMJWQ22kHOnhwwKHOdQndwN23ogv5YEwYy8=
X-Google-Smtp-Source: AGRyM1sNtDGiw6hf77/2a2P1cTuDqhVg3wEykZ7DCfJvtPr1QIJQXTq/XdL/6YVyMfp6GUhEWuszkC0FQNjog4Zv9Xw=
X-Received: by 2002:a17:907:97cd:b0:72f:2df:274f with SMTP id
 js13-20020a17090797cd00b0072f02df274fmr5985160ejc.766.1659182303585; Sat, 30
 Jul 2022 04:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com> <1656894026-15707-10-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1656894026-15707-10-git-send-email-hayashi.kunihiko@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Jul 2022 13:58:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0D4CYqZipY30scDA=KkWR_Az_5i-8avkg6EeDs1nM62w@mail.gmail.com>
Message-ID: <CAK8P3a0D4CYqZipY30scDA=KkWR_Az_5i-8avkg6EeDs1nM62w@mail.gmail.com>
Subject: Re: [PATCH 9/9] ARM: dts: uniphier: Remove compatible
 "snps,dw-pcie-ep" from Pro5 pcie-ep node
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pKJPtwD9dFI4Wj8EfGjqY3UkXplbYTF+HW2fJWzotyGpudZt/Zk
 mePKO+ztZ5k9aTOPgavXfKd3JnQBg8Ml/uKfCVJCD9gdttnY0DUKK3AuQA3HqzISUPudNSH
 3NU6Rpo+0ROavUqlX9EmnSUTAacYA72bX033etWyvr2nrADXb4/xMM2Iu/hxLsZSHSJuLeD
 w5ftVy7N12GZJjfN9Ed9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Zsj7PGIRJ8=:INmDqUjDkFkNJDFWqQjVu4
 /vuRLj7x0aYCpc8cpO7n99gW7EyUZ+SEGD2Npi6RZhR8QMePmfkbsfLQljKaqAjYtECHaHXVS
 HP5vxkIjyYT4Q09WuRpFi5QRnDdwLkfgVG+kYK6bsjv9ZDtxDZwgW8s1siHdiHMoyKu3m007R
 Z0neg4PwR+NjWP+i3gwjyFozvSpZjnqr7pZgjdwBBD0swFEg5VX1Mo/AKAV1tjzE5ZUFIJq76
 YFEC9NaoApMI/W/yTscGd6JiVwhQF3RorgVDazTJ2VVQKG4r7UEORgXRb8dFxqNovxMcT446N
 Xv6CCHDk9W5xR3x65SkRgIg41CL3IXbcq3AKZrabWNoamUipIkHy8v29BeXX3CVvdVIyoZG6O
 xsb7HIujZkK32D6eLv97QYxmwY80L9J3y4LumpbNe4KnpSftwHRO1+hiVxQ7Sh0O14BSqHU1O
 Y/Q8P/14ylpNc8JELwwSsSojw285NXew0iOjFAwc8IjmPXsENpCV1567GNV0BCDiNWmeNtXY9
 qWBwPKW+dQAqvqPpnVnkNDr5Wsq+l5kpfs+XP2W6mwvPuA+QLJWWmxCJcip3Q8/v898wJo1X2
 TyxvwKj5QUNhdwsTLBy/c4sRt7KJUPrOE93wLS9nR5RVw9rSzI+8EJ9ktezUIuHH44QYchl+f
 6UIYwbkhVzbzOp+7pP6p62S7AfNZdb7TICJhgz7LJLRRlExe/hLobBbEtGh7ZjzOjEl8df/WF
 ADg+u24saHEwLTS3+ixd171EbtyKnXUiotdSCTejf5jYmHVdFtFw5dyHMQ6TcBfHm28r8EPb7
 9Nq6S1nF+ugog6V5LqZ1aT0rJlB8RplWBRDJU+TJiBtW9WLnMg/NrE8r5Zs4ztWMgGrR5i8g1
 b/1bIy1Xa/7OHlwzw54w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 2:20 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> UniPhier PCIe endpoint controller doesn't use "snps,dw-pcie-ep" compatible,
> so this is no longer needed. Remove the compatible string from the pcie-ep
> node to fix the following warning.
>
>   uniphier-pro5-epcore.dtb: pcie@66000000: compatible: ['socionext,uniphier-pro5-pcie-ep', 'snps,dw-pcie-ep'] is too long
>       From schema: Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>

This sounds like a problem with the binding rather than the dt file. Is this not
a designware pci endpoint? Should it be documented in that binding instead?

         Arnd
