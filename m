Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2F568B45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGFObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiGFObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:31:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB981EC63;
        Wed,  6 Jul 2022 07:31:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q82so6984998pgq.6;
        Wed, 06 Jul 2022 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w2xT/7PtZ3tagdbQ/WcQuh2A722VFZF5Mx+6h0X0mqc=;
        b=FHhGi4dSerZiLVraVC71UzQcIY/dX8G9dwqPSniHYz1DMQyHRIUrnPpLmMUDhdIt4F
         DC3km78EYNYJvy0k+6SCXJG16xhLsYFmv8RQyARjtNQ3he+v8hRV/CY0OfDAC/B6Lyg8
         pKy90tQXmQmph/4CMz6TdVEyEriDBESocTMUAWCpgudrr5guo838IXSv8HgB/xl6sbk/
         mNbtMqUPRQjxWHhtxjomSOOu31Hhap+BgnuBux3LL9lRneU4fDbCaVC17gJFgJHcfe3S
         NbYCceM2vHwYRb2abNn0GIhMptJ03g2z0K3nh/kZQCCyBn9AJkDhQh1KVjvqw/dHLKXo
         BAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w2xT/7PtZ3tagdbQ/WcQuh2A722VFZF5Mx+6h0X0mqc=;
        b=wfQv7ge7BhSWMU414zE7N8UL+uZRcoRWIxWcZMD45h357MEe881AZn5OTpCuiR9ljj
         +fzO6tR7oXXY4SFww5Ki50mh4ks5672kUJsUVVuyd73GHONBUrYKixsY6UiLTgEeVrYQ
         jj1OQS5U+h8pv68JKZVABGbKuCv9d5FlGZn6xwy4sR5kAjvt1DvF9yTQKwf/XncEwCH9
         dZMxBip9MzEC8bi22Q2uKFTY8G72hN3i+TjXv4faGHDHwG0pn/jolwFkH+6re3dv0PxP
         Ox+Gfz9vAwc+YJqLrNrRN4Ae9GA0fqwhiYQ0SXiucDFf0/Q7FxivBD9t7YrKGHAdmOrf
         Ojmg==
X-Gm-Message-State: AJIora/uD6B9Se+wM2ozYlOIZT+8iWtfemUFaADKiGf0Ss1OYFprXmZq
        2Ehh5cVzIG1EqH8OpS0NSWQ=
X-Google-Smtp-Source: AGRyM1tb3fDyu58P0qGU+xKZ+uH0ststnJ1GBLgXwZPNsLr3hizpL9L5hnRKltaVSZByHQS2CK1VOg==
X-Received: by 2002:a65:6bd6:0:b0:39d:4f85:9ecf with SMTP id e22-20020a656bd6000000b0039d4f859ecfmr35962872pgw.336.1657117873111;
        Wed, 06 Jul 2022 07:31:13 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id mn1-20020a17090b188100b001ef42b3c5besm4505153pjb.23.2022.07.06.07.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:31:12 -0700 (PDT)
Message-ID: <a5544eb7-6044-0b84-cf1c-17ca849c641e@gmail.com>
Date:   Wed, 6 Jul 2022 23:31:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/5] Address some issues with sphinx detection
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org,
        ksummit@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
 <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC: update address of ksummit]

On Tue, 5 Jul 2022 13:15:57 +0900, Akira Yokosawa wrote:
> Hi Mauro,
[...]
> 
> Fedora, RHEL/CentOS, and openSUSE Leap provide helpful packages
> for installing math expression support.
> 
>     Fedora 36               python3-sphinx-latex (python3-sphinx depends on this)
>     RHEL 9/CentOS stream 9  ditto
>     openSUSE Leap 15.4      python3-Sphinx_4_2_0-latex
>                                 (python3-Sphinx_4_2_0 depends on this) or
>                             python3-Sphinx-latex
>                                 (python3-Sphinx depends on this, version: 2.3.1)

These packages are supposed to cover LaTeX packages necessary
for building LaTeX sources the version of Sphinx generates.

HOWEVER, in my test of openSUSE Leap 15.4, pythno3-Sphinx-4_2_0-latex
does not cover texlive-tex-gyre, which is required since Sphinx 4.0.0.

Changelog of Sphinx 4.0.0 [1] says:

> Dependencies
>
> 4.0.0b1
>
> [...]
>   * LaTeX: add tex-gyre font dependency

[1]: https://www.sphinx-doc.org/en/master/changes.html#release-4-0-0-released-may-09-2021

I'm thinking of opening a ticket at openSUSE's bugzilla.

Fedora 36's python3-sphinx-latex (for Sphinx 4.4.0) has
texlive-collection-fontsrecommended and covers texlive-tex-gyre naturally.

        Thanks, Akira

> 

