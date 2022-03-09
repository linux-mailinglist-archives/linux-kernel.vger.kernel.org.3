Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC74D386C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiCISDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbiCISDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:03:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0CFFF8B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:02:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y22so3941818eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9BTio2Awg7juKQM1Om6kj5q4l9NNXHlLZxVh/F8S+tg=;
        b=be0xgrwE9PVElgzZ6mKpD92wnU3cowCGfBc1OV5jhqQ9ZNrW13BtSXpniXtvJqkFSV
         XNo8iD0nRYRqU4CsTnJBA5Uiz5DAcru0dFKX+fcB2tZTKJq9Ps0WaeHnJEf2MaDdeyQi
         okt1bqYGhlDBNU6a49vgHDTGdP3ZrbqgOnXQZ1bIvNvehQ3M59WwjK3n1lPGWdIG4R6A
         SVwEGH25yGjv1UW2ndhuZygOTEUSpEqQZsIWpC9Ro65+Nm7SQubWCK1CtIe40Bf7ORzm
         EakUrFXmOiDqDrsz5GdMpGaZqt6aRt/17Pi7Pr6I277q1j8iLg25Tfh7WGVqepNY81ew
         1TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9BTio2Awg7juKQM1Om6kj5q4l9NNXHlLZxVh/F8S+tg=;
        b=XZPPYPQ2WyJB8cL8wlinOHkI6Voq6dKAy15S8vRnFaW+TJ4jq2AEogvNzip8+nLCRR
         jLLRp7o312srD76SU7Q20QTJMu5JO4spbBthopkH1nWHaiBvqZZ42RzuNOUGyfZMJxO4
         GoCVjznC7uQB/U9kZIYw5KlbvcjCfFJPEtnaadCnWrlfNxCp78psRf/9NvdX2lOqgBXX
         CqCNK1U84tl/AjVrmsWUgcxAYM62Io/F09ztMbMlyKJ957IvUognaLo0sgjOom/xnCYM
         eR37M+wjIRJiHPqpUTf3QD4qVdBt/sN3XPKFmplQCOmFG+drTaSVcxXh82jYX7OGEnqx
         e3tQ==
X-Gm-Message-State: AOAM531tnOuGrhT9QwRnn5bGkrALLIvPbUcOB/g4l4X2oosgoJBe7bX6
        Dlj9hJuXbdsgrJx0W1GUPGVTuNYHFOV7FMbj0FA9+Z5SKpx3qw==
X-Google-Smtp-Source: ABdhPJwoZmSwRaYZ1GZDi9d2zJ8o5t8281Jc2nc5ttT0AwcMmqFD7BA8pvgIUIee3p5wSoosHXA6m59U6mLbl48Mt8I=
X-Received: by 2002:a05:6402:1941:b0:413:2b80:b245 with SMTP id
 f1-20020a056402194100b004132b80b245mr682857edz.252.1646848922413; Wed, 09 Mar
 2022 10:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20220308025547.20412-1-sagarmp@cs.unc.edu> <de1b0152-7521-db6f-355a-b906ecbe84dd@linux.intel.com>
In-Reply-To: <de1b0152-7521-db6f-355a-b906ecbe84dd@linux.intel.com>
From:   Sagar Patel <sagarmp@cs.unc.edu>
Date:   Wed, 9 Mar 2022 13:01:50 -0500
Message-ID: <CAMGmevBHM-mrZsNGHK44yhHY8kipiErBf=tgqQZ5E3LgHO49TQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: use python3 to find codespell dictionary
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 2:58 AM P=C3=A9ter Ujfalusi wrote:
> > In addition, when searching for the dictionary, do not check if the
> > codespell binary exists since codespell can be installed via a Python
> > package manager. In this case, a codespell binary is not exported in
> > $PATH, but a dictionary does exist.
>
> Installing codespell via pip will place the 'codespell' executable under
> the user's $HOME/.local/bin/ and it expects that it is in PATH:

Good point, I'll reword the commit message in v2.

> Having said that, the executable itself is not used by checkpatch.pl, so
>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Thank you!

---Sagar Patel
