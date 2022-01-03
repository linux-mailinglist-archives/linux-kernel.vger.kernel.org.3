Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A794E4838A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiACVsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:48:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E710C061761;
        Mon,  3 Jan 2022 13:48:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e5so21726689wmq.1;
        Mon, 03 Jan 2022 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9dCDiLfbeldB1HjWX1YrC/d8Bc58qG97B0V8rzpWFg=;
        b=hldhc9R3zhX0S3wtlezacyK/3Y2NLhxAEjnksO1QnxLPAvDP8+BO5ZdraS6HmOPwPp
         qJtW6+WcT4NAcWA56joT7djw1wFh51yPUv77OVZeU7CLcV48xTLWygHvKgwzze/GAFrt
         3q9FtRaYDdVADOzgKUuwcymInZzzRm+ULdhe82uXREjs4Qu2aclhp7Sd5BqvPuHHHxYD
         xU/9OYJvrAm2uok7ei3Wu2y+W4dpkWjUA0FpDsrXU7HkXp+8iSaXaijLoRm+JXjoGQSp
         +SoC2kEXLyqDrWnW/hBAY3jV8F+1jOHNL0VFBsZUVVosRPzTLCJ0O1/5f3WUE8lz8L5E
         fAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9dCDiLfbeldB1HjWX1YrC/d8Bc58qG97B0V8rzpWFg=;
        b=oGEuquKCck0ozemmZCWx+N6IwfRQOuyJ3yv8+bcgRAPfOdbURGUOIPAAjuXQUlB9TZ
         wcjo6/he/3Yn+EYz652TPC5pZ+s+e7G1qbMasLvYf2p+UKmRa1QrwlPOenZ1iLRk7ta/
         jiiyz5yMBFSa20gFjoT9z3DWqQSriYg5BfJSF69qudbqGdicivYZ9LsfpEFQsrpjFHyo
         kyJGwFG0X43VaPRUzVKAjZ0bxuDEzKSdGrRLSGEwBVDaTl/oPqXAQf7a+WiIFVOY9jOH
         mFjEcTNIngHt3yBql8kGjQtNRCh/moRunKAwfSUgKc9YV5EI90zCprVkVUcOxZMOYdHu
         nrww==
X-Gm-Message-State: AOAM5322MgQIEJzUVmUpPBtMMIfLw6cexwBy9WRq934YbuuRt0QOvlUq
        hoNKWi+00cbohc+qH7OaR+jYZAGYQHtosg==
X-Google-Smtp-Source: ABdhPJyYyB9SzOCX9KoVSmfrNTbnKw8C3Yx5TnaTBqVqB/wCWKECxTB9YPcIPF4wQMtuSVtKoIF+nA==
X-Received: by 2002:a7b:cb9a:: with SMTP id m26mr35616716wmi.55.1641246490137;
        Mon, 03 Jan 2022 13:48:10 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id l26sm33957392wme.36.2022.01.03.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 13:48:09 -0800 (PST)
Date:   Mon, 3 Jan 2022 22:48:06 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
Message-ID: <20220103224806.2932bac2@fuji.fritz.box>
In-Reply-To: <87bl0sziva.fsf@meer.lwn.net>
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
        <87h7b8cfg0.fsf@meer.lwn.net>
        <0796a780-f5ee-0b6c-e7ef-544ba5f6a429@gmail.com>
        <87pmp9tcju.fsf@intel.com>
        <20220103183034.77ba8a8c@fuji.fritz.box>
        <87bl0sziva.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 13:04:09 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:
>=20
> > On Mon, 03 Jan 2022 11:04:53 +0200
> > Jani Nikula <jani.nikula@linux.intel.com> wrote: =20
> >> In kernel, tabs are 8 characters.
> >>=20
> >> See Documentation/process/coding-style.rst
> >>  =20
> >
> > I am a heretic then.
> >
> > Except for the initial dogma, I understand and agree with the rationale
> > in coding-style.rst.
> >
> > Only what if I have stared at the screen not for 20 hours, but for
> > 40 hours? Now I want to have indentation even deeper, of 16 spaces.
> > And how do I get this having 8 spaces here and there instead of tabs?
> > The system begins to fall apart.
> >
> > The misleading statement is that tabs are 8 characters long. No. They
> > are exactly 1 character long. And that's ASCII 9. =20
>=20
> This is not particularly helpful.

Not helpful? In what matter? It is a matter of fact opinion on
coding-style.rst, which Jani Nikula referred to, so I think it is both
in topic and may be helpful to some. While troublesome to some others,
that's true.

> I would like to get your work in, but need some cooperation to get
> there.
>=20
> Please:
>=20
>  - Post your patch series as a single thread with a coherent cover
>    letter.

Sorry, I'm a newbie in this business. I need to figure out how emails
work. Is this just one thread per version or one thread per all versions?
Can you please direct me to some documentation about this?

>  - Stick with current coding conventions

To be honest, I need to think this over.

>  - Avoid snide comments to reviewers.

My reply is no more snide than coding-style.rst. Compare them. It strictly
relates to it. I don't point my answer at the reviewer in any way, if that's
what you mean.

Ch, TW
