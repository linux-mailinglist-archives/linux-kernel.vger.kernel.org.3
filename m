Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF26B52B652
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiERJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiERJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:10:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9EB13FD4A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:10:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so1723204wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a3p9RWrnEXxuXT6dFm/7R9XKBCQLFHr/hqKCZKCwClw=;
        b=fQrjJ1mkMaN1bDs4bljWNln+PTHlRBIcCuDsEtqZI3kxqy/TCbvnab19SOWxPwBcNx
         Gd7rnjVnpgj4gHHAO8p/VcsKSEl+buT4rUmPNPUDybXMuE1qQoIKtLZmRMEkDDT9xQzZ
         xNr7HixN/r3XvE8advX4UMeflrvwCBfVFePGyQ5gqD9GcM39OwrJalg+HrVG2m9WNBIx
         mkDnzf3oO51nkKsaNTKVkEgSFI+8wrf63eAsf4DVyHBpXDJVTFnzbZ/f5KyZHiOR4r9/
         Xf5ULHRiVN5DlIVYtHH1ratKRFbWL0ganQ6OYpAJKlj0T7TbGf1GhDneNkhohVMVSgJT
         vCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a3p9RWrnEXxuXT6dFm/7R9XKBCQLFHr/hqKCZKCwClw=;
        b=07UeeROc+HffbtST/o6iTnxFWnVbtxDqKJ7BikhVNlKq7tNXyaFQ+sJsezXDtZt1Gn
         idcevcL6CTmkz83OPjexnCzU35Ww+/RUZWT2/O8mEIfjheSnGgQFLqSYebbac1fL8YOI
         MdeSOmUJKl7y4IOVZCBcGFoDdkcuCucxVyiGd0HlydvVKOtCqJgFH97Ne6QlmgLT9xpE
         rmQF5hjTF7wHk2tqFp+YcWCwUPzR61B8FXsg05hUNItxLXSthpZt1fcnmo30hDGkUyGF
         qzMCdTBfVXMO7oztycAu8g4b+kaMmHdo7GGm0bAZNkZotf7ZhkyIxfZsqgwN7gtGSl4R
         zp6A==
X-Gm-Message-State: AOAM530T2uppper62t0a6oJ3TIC/KN1dW9xXt0XQcuZRVOmj30YX6Co7
        0qNRfifcDfFzGN94YmNNMWPG92RQdVH6CY5vcTJ7jw==
X-Google-Smtp-Source: ABdhPJxEBbxF3pXDvjlrj+8J/Mp0IPHVhx92EKQ7mad6xuIFVFaIXgAUqG7xHGRDd0SLlUagfaA23fzfMIzbtsnt99g=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr22568351wrz.690.1652865031225; Wed, 18
 May 2022 02:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220511214132.2281431-1-heiko@sntech.de> <20220518002529.GA1928329-robh@kernel.org>
 <CAAeLtUBLpDHeJHfPtaUb_OLZb_6cUQa1Z_F+06pkdJMSHtWrfQ@mail.gmail.com> <1893094.PYKUYFuaPT@diego>
In-Reply-To: <1893094.PYKUYFuaPT@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 18 May 2022 14:40:17 +0530
Message-ID: <CAAhSdy1sG8uzg0W2Ufi=EYFB58+JZobUa9D+rcHeb4upJoMzng@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>, krzk+dt@kernel.org,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 2:33 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 18. Mai 2022, 10:22:17 CEST schrieb Philipp Tomsich:
> > +David Kruckemyer (who is chairing the CMO task-group within RVI).
> >
> > On Wed, 18 May 2022 at 02:25, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, May 11, 2022 at 11:41:30PM +0200, Heiko Stuebner wrote:
> > > > The Zicbom operates on a block-size defined for the cpu-core,
> > > > which does not necessarily match other cache-sizes used.
> > > >
> > > > So add the necessary property for the system to know the core's
> > > > block-size.
> > > >
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Do=
cumentation/devicetree/bindings/riscv/cpus.yaml
> > > > index d632ac76532e..b179bfd155a3 100644
> > > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > @@ -63,6 +63,13 @@ properties:
> > > >        - riscv,sv48
> > > >        - riscv,none
> > > >
> > > > +  riscv,cbom-block-size:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > >
> > > Any value 0-2^32 is valid?
> > >
> > > > +    description:
> > > > +      Blocksize in bytes for the Zicbom cache operations. The bloc=
k
> > > > +      size is a property of the core itself and does not necessari=
ly
> > > > +      match other software defined cache sizes.
> > >
> > > What about hardware defined cache sizes? I'm scratching my head as to
> > > what a 'software defined cache size' is.
>
> I agree that this should be worded better. The intent was to tell that th=
is
> is different from say the l1-cache-block-size.
>
> I.e. these values can be the same but don't need to be. But I guess I got
> too much lead on by a kernel implementation detail (L1_CACHE_BYTES consta=
nt)

Better to just call it as "the cache block-size expected by Zicbom cache
operations" without getting details of relation with L1 cache block size.

Regards,
Anup

>
>
> > This seems to be a misnomer, as the specification doesn't use the term
> > and rather talks about the "size of a cache block for [operation
> > name]".
> >
> > There are currently two such 'operation sizes' discoverable by software=
:
> > - size of the cache block for management and prefetch instructions
> > - size of the cache block for zero instructions
> >
> > For whatever it's worth, cache operations in RISC-V attempt to
> > disassociate the underlying hardware cache geometry from software.
> > See https://github.com/riscv/riscv-CMOs/blob/master/specifications/cmob=
ase-v1.0.1.pdf
> > for the CMO specification, and the discoverable parameters are listed
> > in section 2.7.
> >
> > Philipp.
> >
> > > > +
> > > >    riscv,isa:
> > > >      description:
> > > >        Identifies the specific RISC-V instruction set architecture
> > > > --
> > > > 2.35.1
> > > >
> > > >
> >
>
>
>
>
