Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA23558746A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiHAXa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiHAXa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:30:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EABC5E;
        Mon,  1 Aug 2022 16:30:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so10086993ejp.2;
        Mon, 01 Aug 2022 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DVzNbdvjtJZyb6fusz8zmo9vzab+/DLNo5uVFWXIF4=;
        b=DJiMcZHyta8H5GXobiOBTrib8UDEaVIMGZAruyTYUn3KosZBsuKpOk+fIB2Eh7AMrB
         RjW7Bujn7M9Kuz4fnR6gbLZKDOdulBNplLyV8+lPuMXXRHYdVD98YJt2+kWU2KFazhH8
         57sEpo4VGsvrTly8+4ZMeSLXopJn4K126V6pBK3XeFkDzCujr+GT1YnRcbvBJc8EXAu/
         kEdhBF7L7O+OH/jli6nOA6XcLyFlk5UTTNYhzmEYyiT2U3vGOSRDx43hXQq7D9aLk/10
         rPqgxMMlVl0caSkM1cO5FUfOdrNpLuN0RgeFw2ze40oDj723rurdvyxJIUnwycEqbE1w
         7tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DVzNbdvjtJZyb6fusz8zmo9vzab+/DLNo5uVFWXIF4=;
        b=1T/2Np89WDoE9XPdbnyADvoiAsXgcTQOk5atFhKpr8ScxzQRucJkefjao2w9EWMllL
         fsFlYiVbsI36nl8ljsU7EIH0VdNi1wIq9LAI6FGzfv9TfHvugh5xJQQF6r9RKFEkdH2M
         xYTsDywy4aQjELkhRfu/FJDtXBURKPKWLhwbNfFdzCxJmmE0LA1cJbP6amDGr7ecGyuQ
         gcJYTnIuzLBYdbEGsNXiz742zQxSadiZMi6yPikKqWh4pbnssV9A/rdq+cArRCqss1Q+
         JTUNVywBjsxdIr6WRoYP0yWlqIREI8iB+8XIhKEediyXmbnt7GHOZTr9s3dKAm41rnOV
         Kjpw==
X-Gm-Message-State: ACgBeo3UegLajsKzv8wCCWI8RS2N4QVFM5hOToCGVlD1vBCq7ZmsIrax
        Gu51n0qZgFLv/BH6uANLvEXpYqD6XpY=
X-Google-Smtp-Source: AA6agR7Ct8CEoWeoaEh5H+jBgBHyM6IMtOXArpCZX+KhPbQ3Ai6pqY6ofCf0LSAE9kKo7sGLcj4e6A==
X-Received: by 2002:a17:907:781a:b0:730:95ad:f811 with SMTP id la26-20020a170907781a00b0073095adf811mr2987611ejc.684.1659396623085;
        Mon, 01 Aug 2022 16:30:23 -0700 (PDT)
Received: from dev (188.146.70.50.nat.umts.dynamic.t-mobile.pl. [188.146.70.50])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072ecef772a7sm5585342ejh.160.2022.08.01.16.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 16:30:22 -0700 (PDT)
Date:   Tue, 2 Aug 2022 01:30:18 +0200
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        ksummit-discuss@lists.linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 0/5] Address some issues with sphinx detection
Message-ID: <20220802013018.5897f161.tomasz.warniello@gmail.com>
In-Reply-To: <cover.1656756450.git.mchehab@kernel.org>
References: <CAHk-=wjYBONGGhiQu2iTP6zWu8y2a4=ii4byoomf6N77-pJNeA@mail.gmail.com>
        <cover.1656756450.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Jul 2022 11:11:24 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> There are two options to install Sphinx:
> 
> 	- via distro-provided packages;
> 	- via pip, using virtualenv/venv.

There are countless ways to install any software. So much for my entrée.

*

I don't know this script. Just what I've read in this thread and what I could
extract from it in no more than ten minutes. I understand what it does - or
rather I do just approximately. And alright! Why not help the Gentoos and
Fedoras and Etc's. Noble.

But - wouldn't it be million times easier for all parties to base the support
on a Dockerfile? Or a script producing the right Dockerfile possibly,
considering matters like Java Script opt- ins and outs. If this is not a
cheap pedantry in this context. I don't know.

These here bases look quite official:

https://hub.docker.com/u/sphinxdoc

(Not that I've used them or know them.)

The admins of whichever distribution will find their ways in the mesh, raw
requirements suffice.

The non-admins may have problems with installing software and also running
Docker, as that provides su powers in the straight scenario. `pip` comes as
an alternative, if I'm not wrong. So maybe this pair is the golden arrow?

--thanks
T
