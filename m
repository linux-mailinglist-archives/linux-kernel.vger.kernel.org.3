Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECA46E463
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhLIIl4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 03:41:56 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:33625 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhLIIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:41:13 -0500
Received: by mail-ua1-f50.google.com with SMTP id a14so9465030uak.0;
        Thu, 09 Dec 2021 00:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/wHJKw72IgLDQBov78fTqhQ5wmrHUQsgonD8JrpOVc0=;
        b=nNVyCZItkQB6t0PxUpdQqno4RTxV1HcmPXFb8Zm06syLcue/y5Csyc3kDBs/C4Uf/D
         SBBNGQFYvdbNCCVubLG+EZAX21pslPS7JX7CMO9LET8aOnEnM6GdMm48mPZbyvXDU4k/
         CDd/u/LIeX9RplhfymLptmwru04Y0IqhM5eWTFiRNZS4uu7hyzO8x5M0STOkN6uVziVm
         h/oBIx31KZolXnpx37pj/q2KK3o9YdOIwcFXFAaroqEzVL1XFn7F7v2ganpVKlhn/1TH
         QcZ7yyHZKIA2YhhW4ComOLFHZ8DCQPzG2oQVUnuK+U7LHuePNrsZGmEP1JuGieXMJh8B
         7OYw==
X-Gm-Message-State: AOAM530cxmCaEhUvt9S8tT0aJIm49X7iRY/Zx7ahoQ6z+GUhz8sPSAdP
        4352gl3LMp9VyUO1kL2l7nHg1V4xZ8CHlw==
X-Google-Smtp-Source: ABdhPJwbCkbduIdqNrb1k4q817zDR8z5HkgwiI7O7a6DY7GEyzlrguZexBsOBQQEQ75c9KecMvwdbQ==
X-Received: by 2002:a67:fdc3:: with SMTP id l3mr5815925vsq.42.1639039059186;
        Thu, 09 Dec 2021 00:37:39 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id j19sm903vka.4.2021.12.09.00.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:37:38 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id s1so3242919vks.9;
        Thu, 09 Dec 2021 00:37:38 -0800 (PST)
X-Received: by 2002:a05:6122:2193:: with SMTP id j19mr6958885vkd.7.1639039058208;
 Thu, 09 Dec 2021 00:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20211208132042.3226275-1-gsomlo@gmail.com> <20211208132042.3226275-3-gsomlo@gmail.com>
 <1639004806.166681.596177.nullmailer@robh.at.kernel.org> <YbFXERe0K3rfzZem@glsvmlin.ini.cmu.edu>
In-Reply-To: <YbFXERe0K3rfzZem@glsvmlin.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Dec 2021 09:37:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJZdzRMedn9L_Jb=0MYB_Bxs90v+iH7UaDBzup-qzp8A@mail.gmail.com>
Message-ID: <CAMuHMdVJZdzRMedn9L_Jb=0MYB_Bxs90v+iH7UaDBzup-qzp8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        mdudek@internships.antmicro.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mateusz Holenko <mholenko@antmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Thu, Dec 9, 2021 at 2:08 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> ... which took care of the bulk of the error messages reported. However,
> I'm still getting the one below, whether or not I leave the `maxItems 1`
> line there under `clocks:`
>
> $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-  dt_binding_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> /home/somlo/linux/Documentation/devicetree/bindings/clock/litex,clock.yaml: properties:clock-output-names: {'description': 'List of strings of clock output signal names indexed by the first cell in the clock specifier.', 'minItems': 1, 'maxItems': 7, 'items': [{'const': 'CLKOUT0'}, {'const': 'CLKOUT1'}, {'const': 'CLKOUT2'}, {'const': 'CLKOUT3'}, {'const': 'CLKOUT4'}, {'const': 'CLKOUT5'}, {'const': 'CLKOUT6'}]} should not be valid under {'required': ['maxItems']}
>         hint: "maxItems" is not needed with an "items" list
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml#
>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> /home/somlo/linux/Documentation/devicetree/bindings/clock/litex,clock.yaml: ignoring, error in schema: properties: clock-output-names
> warning: no schema found in file: ./Documentation/devicetree/bindings/clock/litex,clock.yaml
>   DTEX    Documentation/devicetree/bindings/mmc/litex,mmc.example.dts
>   DTEX    Documentation/devicetree/bindings/media/renesas,imr.example.dts
>   ...

--- a/Documentation/devicetree/bindings/clock/litex,clock.yaml
+++ b/Documentation/devicetree/bindings/clock/litex,clock.yaml
@@ -45,7 +45,6 @@ properties:
       List of strings of clock output signal names indexed
       by the first cell in the clock specifier.
     minItems: 1
-    maxItems: 7
     items:
       - const: CLKOUT0
       - const: CLKOUT1

I have that in my local tree, but hadn't sent it to you yet, because
litex,clock definitely need more work.

> It appears as though `make dt_binding_check` is trying to read from
> `Documentation/devicetree/bindings/clock/litex,clock.yaml`, which
> does not exist. The clock reference I'm talking about could be *any*

Oh, it does exist in your tree ;-)
To check the examples, it has to apply all other binding files that
might apply, hence some checks are always run.

You can avoid some (but not all) such checks by adding

    DT_SCHEMA_FILES=Documentation/devicetree/bindings/path/to/binding.yaml

> clock elsewhere in the dts!
>
> This wasn't part of the originally reported errors, not sure why I'm
> seeing it now. Also, not sure what (if anything) I still need to do
> about it, any advice much appreciated!

Of course, as Rob doesn't have that file in his tree.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
