Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40EB4F20ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiDECwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiDECvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:51:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E140E9CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:25:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so20287283ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 19:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xf+oV+TQ+5NDWUw2TSB8GHxPjMiV0X8mJqCtnmq1h54=;
        b=IZ/pYISQjpqBZbiltTT/WrDco0L+UDSVCXi/c0EZ4yBll7GLNYxZ4Lxe2qBpJCz4jr
         WSIdszFNDjOzlkvOTbwfjuLvS7h5f2qquwccRx6/NOdolMNfwY3aYe7IeWiG3KuXcQyV
         EszTfDkwFu1loY8r7YR3WaRZW27jVWwfUqKXbRdOpg9vPgmmotBjph7FZR6M+oyQNWf5
         8IcoI4qKqn/eWi7cNqnHIHf7aTK1KC001lrpapboZC8Yof+IJUYH4EazOzrRAyleNL9V
         F3y3Ar7tyZophINeQ4BZ568W7bK9ZoUvwi45qvhLGj7yCjIghC0Dg4FTXuKsQfF5htP4
         0WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xf+oV+TQ+5NDWUw2TSB8GHxPjMiV0X8mJqCtnmq1h54=;
        b=8JfsZrNE+G71NKCcoo+BcmC4DKGhDQ5ZX4nloLXVDmbGoEAUTJJZTsd4fAvVF+JJ2I
         8E/POSAl5yxCDCl+lsKKouFFQr3quiiQUFRv/he6K++QZmrnC5/4ou2CSkeNpg507oSm
         FoVR1xbyzx4YhfInp/IAKP684FTWshxNy7cYZZeOlTPblqT2CbnyC/SYvBmlr0C+YKTL
         /wPZ3wmBPUYZVpJEJWTnWz4Rv4Bve0swnf3iC9H9E8qmr7wF0rLoJUjWcKU7iEtEDhpc
         0llzp2SgZ9/EFxIc7xUu2aE6Wq2Sa8Hhuv7byJV0asPs5AqzBWlRKbh/GGtVUofCwQ9p
         4qpA==
X-Gm-Message-State: AOAM532gg3P4Hp1nw0ua1clJT6Mz2tqBsYKMHvnhhY4Kw/iM8gJltaaQ
        nBXhhgHcvbzuJ8UwKW69kEt/WFEIHPr8kbq6qew=
X-Google-Smtp-Source: ABdhPJwX+/I+kxRm2+sQeqq1m7f5/T5Gwt7pAce4r+2PTapWU/k4qaVrP3KLNhksU3gamWzyrPFPQXLZq1j1humi64g=
X-Received: by 2002:a17:907:c0c:b0:6d1:8c46:6415 with SMTP id
 ga12-20020a1709070c0c00b006d18c466415mr1267123ejc.326.1649125521091; Mon, 04
 Apr 2022 19:25:21 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Tue, 5 Apr 2022 03:24:57 +0100
Message-ID: <CAHpNFcN15GZ2pbutgkw17KyjzpDGCsGXhgM4-9hwBfL0-6G_1A@mail.gmail.com>
Subject: HDD,SDD & Subject: Hardware Dual Encrypt & Decrypt : Hardware Accelerators
To:     "Kramer, Lou" <lou.kramer@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDD,SDD normally have the EIDD DDI Equivelant

https://lore.kernel.org/all/20220404194510.9206-2-mario.limonciello@amd.com/

Subject: Hardware Dual Encrypt & Decrypt : Hardware Accelerators


(indirect) - Plan & method RS

Modulus Dual Encrypt & Decrypt package : Processor feature (c)RS

AES-CCM & AES-GCM & Other Cypher Modulus + CCM & GCM can be
accelerated with a joint AES Crypto module,

Processor feature & package : Module list:

2 Decryption pipelines working in parallel,
With a Shared cache & RAM Module
Modulus & Semi-parallel modulating decryption & Encryption combined
with Encapsulation Cypher IP Protocol packet

Parallax Cryptographic Processing Unit: RS

The capacity To Multiply decryption on specific hardware in situations
such as lower Bit precision is to be implemented as follows:

On AES-NI & ARM Cryptographic processors; In particular PPS(ARM+) & SiMD ..

The capacity to exploit the fact that the nonce is 16Bit to 64Bit &
full float upto 128Bit for legal decryption (client) means there is a
simple method to use:

In situations that a AES-NI & ARM Cryptographic unit can process 2
threads on a 256Bit Function we can do both the main 128Bit/192Bit &
the nonce 16Bit to 64Bit & Enable a single instruction Roll to
Synchronise both The main HASH & Nonce.

AES & Crypto hardware can utilise the CPU/GPU/Processor FPU & SiMD to
decrypt the nonce (smaller so fast) & in the same 8bto to 64Bits of
code; Inline & parallax the cryptographic function.

With a 256Bit AES-NI & Cryptographic unit : Parallel Decryption &
Return Encryption by using 2x 128Bit & a Processor Enciphered Nonce.

(c)Rupert S

*reference* https://bit.ly/VESA_BT

Dual Encrypt & Decrypt : Hardware Accelerators (indirect)
https://lkml.org/lkml/2022/4/4/1153
https://lore.kernel.org/linux-crypto/20220223080400.139367-1-gilad@benyossef.com/T/#u,

Performance Comparison of AES-CCM and AES-GCM Authenticated Encryption Modes
http://worldcomp-proceedings.com/proc/p2016/SAM9746.pdf

Basic comparison of Modes for Authenticated-Encryption -IAPM, XCBC,
OCB, CCM, EAX, CWC, GCM, PCFB, CS
https://www.fi.muni.cz/~xsvenda/docs/AE_comparison_ipics04.pdf

*****

ICE-SSRTP GEA Replacement 2022 + (c)RS

"GEA-1 and GEA-2, which are very similar (GEA-2 is just an extension
of GEA-1 with a higher amount of processing, and apparently not
weakened) are bit-oriented stream ciphers."

GEA-2 > GEA-3 is therefor 64Bit Safe (Mobile calls) & 128Bit Safe
(Reasonable security)
SHA2, SHA3therefor 128Bit Safe (Reasonable security Mobile) ++
AES & PolyChaCha both provide a premise of 128Bit++

So by reason alone GEA has a place in our hearts.

*

ICE-SSRTP GEA Replacement 2022 + (c)RS

IiCE-SSR for digital channel infrastructure can help heal GPRS+ 3G+ 4G+ 5G+

Time NTP Protocols : is usable in 2G+ <> 5G+LTE Network SIM

ICE-SSRTP Encryption AES,Blake2, Poly ChaCha, SM4, SHA2, SHA3, GEA-1 and GEA-2
'Ideal for USB Dongle & Radio' in Rust RS ' Ideal for Quality TPM
Implementation'

"GEA-1 and GEA-2, which are very similar (GEA-2 is just an extension
of GEA-1 with a higher amount of processing, and apparently not
weakened) are bit-oriented stream ciphers."

IiCE-SSRTP : Interleaved Inverted Signal Send & Receive Time Crystal Protocol

Interleaved signals help Isolate noise from a Signal Send & Receive ...

Overlapping inverted waves are a profile for complex audio & FFT is the result.

Interleaved, Inverted & Compressed & a simple encryption?

*

Time differentiated : Interleave, Inversion & differentiating Elliptic curve.

We will be able to know and test the Cypher : PRINCIPLE OF INTENT TO TRUST

We know of a cypher but : (Principle RS)

We blend the cypher..
Interleaved pages of a cypher obfuscate : PAL CScam does this

Timed : Theoretically unique to you in principle for imprecision, But
we cannot really have imprecise in Crypto!

But we can have a set time & in effect Elliptic curve a transient variable T,
With this, Interleave the resulting pages (RAM Buffer Concept)

Invert them over Time Var = T

We can do all & principally this is relatively simple.

(c)RS

*

Modulus Dual Encrypt & Decrypt package : Processor feature (c)RS

AES-CCM & AES-GCM & Other Cypher Modulus + CCM & GCM can be
accelerated with a joint AES Crypto module,

Processor feature & package : Module list:

2 Decryption pipelines working in parallel,
With a Shared cache & RAM Module
Modulus & Semi-parallel modulating decryption & Encryption combined
with Encapsulation Cypher IP Protocol packet

Parallax Cryptographic Processing Unit: RS

The capacity To Multiply decryption on specific hardware in situations
such as lower Bit precision is to be implemented as follows:

On AES-NI & ARM Cryptographic processors; In particular PSP+PPS(ARM+) & SiMD ..

The capacity to exploit the fact that the nonce is 16Bit to 64Bit &
full float upto 128Bit for legal decryption (client) means there is a
simple method to use:

In situations that a AES-NI & ARM Cryptographic unit can process 2
threads on a 256Bit Function we can do both the main 128Bit/192Bit &
the nonce 16Bit to 64Bit & Enable a single instruction Roll to
Synchronise both The main HASH & Nonce.

AES & Crypto hardware can utilise the CPU/GPU/Processor FPU & SiMD to
decrypt the nonce (smaller so fast) & in the same 8bto to 64Bits of
code; Inline & parallax the cryptographic function.

With a 256Bit AES-NI & Cryptographic unit : Parallel Decryption &
Return Encryption by using 2x 128Bit & a Processor Enciphered Nonce.

(c)Rupert S

*reference*

Performance Comparison of AES-CCM and AES-GCM Authenticated Encryption Modes
http://worldcomp-proceedings.com/proc/p2016/SAM9746.pdf

Basic comparison of Modes for Authenticated-Encryption -IAPM, XCBC,
OCB, CCM, EAX, CWC, GCM, PCFB, CS
https://www.fi.muni.cz/~xsvenda/docs/AE_comparison_ipics04.pdf


*

Example of use:

Nostalgic TriBand : Independence RADIO : Send : Receive :Rebel-you trade marker

Nostalgic TriBand 5hz banding 2 to 5 bands, Close proximity..
Interleaved channel BAND.

Microchip clock and 50Mhz Risc Rio processor : 8Bit : 16Bit : 18Bit
Coprocessor digital channel selector &

channel Key selection based on unique..

Crystal time Quartz with Synced Tick (Regulated & modular)

All digital interface and resistor ring channel & sync selector with
micro band tuning firmware.

(c)Rupert S

*

Good for cables ? and noise ?

Presenting :  IiCE-SSR for digital channel infrastructure & cables
<Yes Even The Internet &+ Ethernet 5 Band>

So the question of interleaved Bands & or signal inversion is a simple
question but we have,

SSD & HDD Cables & does signal inversion help us? Do interleaving bands help us?

In Audio inversion would be a strange way to hear! but the inversion
does help alleviate ...

Transistor emission fatigue...

IiCE-SSRTP : Interleaved Inverted Signal Send & Receive Time Crystal Protocol

Interleaved signals help Isolate noise from a Signal Send & Receive ...

Overlapping inverted waves are a profile for complex audio & FFT is the result.

Interleaved, Inverted & Compressed & a simple encryption?

Good for cables ? and noise ?

Presenting : IiCE for digital channel infrastructure & cables <Yes
Even The Internet &+ Ethernet 5 Band>

(c) Rupert S

https://science.n-helix.com/2018/12/rng.html

https://science.n-helix.com/2022/02/rdseed.html

https://science.n-helix.com/2017/04/rng-and-random-web.html

https://science.n-helix.com/2022/02/interrupt-entropy.html

https://science.n-helix.com/2021/11/monticarlo-workload-selector.html

https://science.n-helix.com/2022/03/security-aspect-leaf-hash-identifiers.html


Audio, Visual & Bluetooth & Headset & mobile developments only go so far:

https://science.n-helix.com/2022/02/visual-acuity-of-eye-replacements.html

https://science.n-helix.com/2022/03/ice-ssrtp.html

https://science.n-helix.com/2021/11/ihmtes.html

https://science.n-helix.com/2021/10/eccd-vr-3datmos-enhanced-codec.html
https://science.n-helix.com/2021/11/wave-focus-anc.html
https://science.n-helix.com/2021/12/3d-audio-plugin.html

Integral to Telecoms Security TRNG

*RAND OP Ubuntu :
https://manpages.ubuntu.com/manpages/trusty/man1/pollinate.1.html

https://pollinate.n-helix.com

*

***** Dukes Of THRUST ******

Nostalgic TriBand : Independence RADIO : Send : Receive :Rebel-you trade markerz

Nostalgic TriBand 5hz banding 2 to 5 bands, Close proximity..
Interleaved channel BAND.

Microchip clock and 50Mhz Risc Rio processor : 8Bit : 16Bit : 18Bit
Coprocessor digital channel selector &

channel Key selection based on unique..

Crystal time Quartz with Synced Tick (Regulated & modular)

All digital interface and resistor ring channel & sync selector with
micro band tuning firmware.

(c)Rupert S

Dev/Random : Importance

Dev/Random : Importance : Our C/T/RNG Can Help GEA-2 Open Software
implementation of 3 Bits (T/RNG) Not 1 : We need Chaos : GEA-1 and
GEA-2 Implementations we will improve with our /Dev/Random

Our C/T/RNG Can Help GEA-2 Open Software implementation of 3 Bits
(T/RNG) Not 1 : We need Chaos : GEA-1 and GEA-2 Implementations we
will improve with our /Dev/Random

We can improve GPRS 2G to 5G networks still need to save power, GPRS
Doubles a phones capacity to run all day,

Code can and will be improved, Proposals include:

Blake2
ChaCha
SM4
SHA2
SHA3

Elliptic Encipher
AES
Poly ChaCha

Firstly we need a good solid & stable /dev/random

So we can examine the issue with a true SEED!

Rupert S https://science.n-helix.com/2022/02/interrupt-entropy.html

TRNG Samples & Method DRAND Proud!

https://drive.google.com/file/d/1b_Sl1oI7qTlc6__ihLt-N601nyLsY7QU/view?usp=drive_web
https://drive.google.com/file/d/1yi4ERt0xdPc9ooh9vWrPY1LV_eXV-1Wc/view?usp=drive_web
https://drive.google.com/file/d/11dKUNl0ngouSIJzOD92lO546tfGwC0tu/view?usp=drive_web
https://drive.google.com/file/d/10a0E4Gh5S-itzBVh0fOaxS7JS9ru-68T/view?usp=drive_web

https://github.com/P1sec/gea-implementation
