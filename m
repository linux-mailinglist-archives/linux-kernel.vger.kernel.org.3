Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C352E44F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 07:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbiETFUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 01:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiETFUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 01:20:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7914ACB7;
        Thu, 19 May 2022 22:20:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l14so7089651pjk.2;
        Thu, 19 May 2022 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=K/PLBiF8Pr/q148VNplDk1LNNEks0HlLVS4FECpFtk0=;
        b=a45I9bHlZV03TA7eJ0Gqj3Yo+YCLPnzGR4M3xiFGag+OkiHUoIbvwcm3PAgpDSXyd7
         HZccCAHPSm2HIZurxjkVdift9KYhmqlKevSifKh0/uohYNDtcCpsyenlpNBzAPalqIsz
         PH54PqmMif6iYj1H1U48MFxrJJXFanHiAzL85jQ769Mp44bhlpphQqb7XrSMEr2Q8MgM
         4ze9lqLA2x7V0f1FkDPIu/gZaklrBHRME9LGRvtC54LHh9BlALkR+YVEAn5ky0hE6No7
         owHzghdSWtsgw/oyJ4rj6Eq5KxnfgjClgl2/gquH2AT0rf99whsYfapUZUblItJi/b21
         dS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=K/PLBiF8Pr/q148VNplDk1LNNEks0HlLVS4FECpFtk0=;
        b=36g1KYGZfFLwZpKseVuFZK5Rxjpr1SL8yvTdhu3+WNktJcQw82Zt4FezQv9GnHjRCK
         T5kzCftMLtxG7cZ9N/mAiV7xE3VvFAuXhbUCZGwteiLlGHoyfrekghHAt6HV3O3IH8l8
         pbr1ukj9tqwqYjuPCOKLgav0OTvV9r61ph8TJSxc6AGsprl9iiknnM1PlkoMflRv8FPZ
         E28LEq5tfozNMgHlcGF5amsL+1Ech15kOQu3DoiZ/ZiNWPl9py7hyiVsH0kKOYHJxAbe
         2u6kFxUKd+urQIiGCjOOCls1Lixs03+kbihzhwfwJBIGrTethVnu5qcgJsyGBSEvX8+P
         /APA==
X-Gm-Message-State: AOAM532LS4SRGFeiLWjl9i13J4Q2PORFu9ywiGr8Sh3ZMhpzkkzBHwDv
        o471bm4O4dfvAB3lMO8qNec=
X-Google-Smtp-Source: ABdhPJzLLdrQb7wEGqpXwdFGZfgit5YL1MLncUe7A4KvktQcB+Cd07elCLJYs79pl9bpMbEEnunm3w==
X-Received: by 2002:a17:90a:a614:b0:1df:8aec:cc71 with SMTP id c20-20020a17090aa61400b001df8aeccc71mr8842631pjq.82.1653024017882;
        Thu, 19 May 2022 22:20:17 -0700 (PDT)
Received: from localhost ([203.87.15.124])
        by smtp.gmail.com with ESMTPSA id y76-20020a62ce4f000000b004fa743ba3f9sm711520pfg.2.2022.05.19.22.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 22:20:17 -0700 (PDT)
Date:   Fri, 20 May 2022 15:20:12 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the powerpc tree
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <20220520083150.57e953fc@canb.auug.org.au>
In-Reply-To: <20220520083150.57e953fc@canb.auug.org.au>
MIME-Version: 1.0
Message-Id: <1653023904.pbe3pabbua.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Stephen Rothwell's message of May 20, 2022 8:31 am:
> Hi all,
>=20
> Commits
>=20
>   03a2e65f54b3 ("KVM: PPC: Book3S Nested: Use explicit 4096 LPID maximum"=
)
>   18827eeef022 ("KVM: PPC: Remove kvmppc_claim_lpid")
>=20
> are missing a Signed-off-by from their authors.

Sorry.

> The first is just "Signed-of-by" misspelling.  The second is missing.

My laptop's 'f' key has got much worse since then :(

Thanks,
Nick
