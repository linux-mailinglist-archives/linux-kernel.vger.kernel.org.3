Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F104DC942
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiCQOwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiCQOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:52:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2420288E;
        Thu, 17 Mar 2022 07:50:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so3393505pjb.1;
        Thu, 17 Mar 2022 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ult9/ByMuaDuRWu9wegLfYo3cD7pdC8YBvUdPcfln2g=;
        b=T517SpSpDL+enl1+v3+I5yfkt5E2hHJD3z2stzP5AjDTOC8WuLind6JgtHAHp3Ls3R
         Lt/8f1MGkzeT5ibHptTfBMVtCk4utRyLvrxBSu+b+Q6tlV2alIsMSx0CeqCev2uy0KjC
         rlVOljaoT02QJvvX2oOPaNOocwhCqhLFph8FEC7MVLQ8bQOZMs3LfBtIPLuxm1n0t+Po
         UUy32UY+2ssqYQWEJ9GXwOrCvflP889u5QcG+npuSm9/o4Z6jt8LdhnqEkYCkHFDzIHa
         kwouUOcXo4LOjjhg1cUKUewGnzffGol1GQgEtqx8+Z1xODWPt9AIS2axbo16hhyyUOMa
         zDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ult9/ByMuaDuRWu9wegLfYo3cD7pdC8YBvUdPcfln2g=;
        b=oC77KhE2hcvigVqmwX6tKT08MprdCaSP10XIBqe7CAqZw63uriHuvOqD8YQ307VqPe
         18609hQ8dZzAQJX7Pmd7lbfvvV9eChG6jgvaG0slHRmNAqTRAFJQbSqGzBPok4Czi4TI
         EPHZvexN2lbCBn4xIC2gRUqSF0IXI/PJnuEqoU1XS5wmduKhGgxKYrDnfn3LdjHoJMmW
         Cg8DkKFF/984v81R+/vMcXkpjrMzfzjsbIVJ4tpF9LrCCinYQkX5E1QIv7eYPr08jwEq
         Mid9ZmKS0zG92VgqR2K19PpLckDb3ncNsBl6vVpa/s9VJump7t8kQP6kllMT8MxrJ+Zv
         yKuw==
X-Gm-Message-State: AOAM532kByZGOGXne1UlGHjMK7QM3hxzV5u3F5IY66x3PlwSZrARKKj/
        NML34fDN1hw8+1fa2Xb/9Ck=
X-Google-Smtp-Source: ABdhPJzFCIQ9U1a5Ff/NkoQwA2u5QpYwRvFkzLuMNq8vKBUpmH511ahdUg5ea8QEBhH0/mIsgY9mHg==
X-Received: by 2002:a17:90b:4b4a:b0:1bf:83d:6805 with SMTP id mi10-20020a17090b4b4a00b001bf083d6805mr16755000pjb.174.1647528650948;
        Thu, 17 Mar 2022 07:50:50 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004f7e3181a41sm7579754pfc.98.2022.03.17.07.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 07:50:50 -0700 (PDT)
Message-ID: <61547556-790f-f74f-ca2e-b2fde714a7fa@gmail.com>
Date:   Thu, 17 Mar 2022 23:50:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 15/20] docs: add Rust documentation
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Wu XiangCheng <bobwxc@email.cn>, Daniel Xu <dxu@dxuuu.xyz>,
        Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20220212130410.6901-16-ojeda@kernel.org>
 <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
 <CANiq72mQffofeW4C=AWF4CHu=WpgpwB4hAv_q9QiTX_+U38qGg@mail.gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <CANiq72mQffofeW4C=AWF4CHu=WpgpwB4hAv_q9QiTX_+U38qGg@mail.gmail.com>
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

Hi Miguel,

On Thu, 17 Mar 2022 09:19:37 +0100,
Miguel Ojeda wrote:
> Hi Akira,
> 
> On Mon, Feb 14, 2022 at 11:47 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>>
>>> diff --git a/Documentation/rust/logo.svg b/Documentation/rust/logo.svg
>>> new file mode 100644
>>> index 000000000000..65be792a5abe
>>> --- /dev/null
>>
>> How about adding a suitable license identifier in a comment?
> 
> For the next round, I did not apply this suggestion, because it is
> unclear which license identifier to use: it would be probably be the
> same as the `COPYING-logo` one (which would be used also for the Tux
> SVG, if it gets merged -- it was sent a while ago).

I see.

As I see v2 15/20, the SVG figure is among other documentation updates.
IIUC, this figure/logo was in PNG at first, but Jon suggested vector graphics.
If this is the case, it deserves an individual patch with a changelog
explaining why it is in SVG, where the Tux figure came from, what was the
original PNG logo, who contributed the SVG conversion, etc.

I understand you did all the SVG work, didn't you?
I don't think those many Co-developed-by tags apply to this figure.

I'm saying this because this figure/logo can be reused in other open-
source projects on its own.  It would be worth clarifying its origin 
in the Git history as well as in COPYING-logo.

        Thanks, Akira

> 
> Cheers,
> Miguel
