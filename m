Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E0C50B19B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444831AbiDVHcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444829AbiDVHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:32:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0B05158B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:29:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so4494459wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=lB4iKTGk3M7LJjGdKeHTAN3EN1YcQuPFYEeXUsvm40A=;
        b=gn/K61fp0L9YQq1130+18t5MUzpqjZ0npz9PW5DzS6kWqgdxc3s/69uYG0Z15pdqL3
         lVQkTVYzhirxsTRWBu+nScZm3T3xQXOSWLJ6jlYxR8J18K5CJfsgFjrlj4CIl9TUJhmz
         1R6PDFEb1ZmUcj5D9IFMD+scJuP9sT6cxa1pipj0RY7mgWdHFvdHt9pqGUO2+NyksCeM
         6Jq6TQLpRdMy5f/bickWV23kIFfMnpSiNodbHqWDVj4Wyo6KkSE4o3WkYnxHiA9Xy2FS
         yUKVMtGHXToWbSJIxW7Sc8lTXSN3BDGUf3muOhJlMimc6kxrCfzhmeefV5GV3GomhSaI
         XZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=lB4iKTGk3M7LJjGdKeHTAN3EN1YcQuPFYEeXUsvm40A=;
        b=xlvikdT+tORZbnHHlURz6tgIzQRQYjLBawuxRhkcaYybKZQaoYfedpGbZ9L3tjOj3E
         MeQKP9OhGcOqqjkagxS1zOMPEQmaTzg0YapGraI8nWgekMCNn/T0hw73Z8vQuUz0PtlL
         +nUQePhrvM9dc+9W3X7WLz5DAdoUxBTiRryt+jd2LxdnAH0dqwIKfkbz08GjUM/NZKIo
         zDV24dZlQe0d5Nbab32/993MbTCOqFpsuxxktmYhvyuLuTgsMNrGXteHAwZJ2adVmj5e
         f3ig35NT63hvK4yPBH8fCgXfye+wAIOTiSj/4oX0LKxB72JHgPDQZCTzL0h1+Vkgn2Sr
         4+uQ==
X-Gm-Message-State: AOAM533xFpXUQozDtGH8dHYpsp3eSljLneL6ZzcmNd/52zOhJSUAVN6f
        fW33XAIC3TebpJGJXA9/P8oNpFv++0BBLSuBg4Q=
X-Google-Smtp-Source: ABdhPJznT4IyyGDZMiSWrk3S2VvjRvuB1ZKZXs32IAWr3vTQ+engqDmsjq2aO4IHPr715oKvNvewnYf5DVpvisHvS+s=
X-Received: by 2002:a05:600c:1c1f:b0:38e:c425:5b1a with SMTP id
 j31-20020a05600c1c1f00b0038ec4255b1amr2789716wms.69.1650612549374; Fri, 22
 Apr 2022 00:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:8e:b0:1cb:9967:3383 with HTTP; Fri, 22 Apr 2022
 00:29:08 -0700 (PDT)
Reply-To: alexnorman438@gmail.com
From:   Alex Norman <robertedward0065@gmail.com>
Date:   Fri, 22 Apr 2022 09:29:08 +0200
Message-ID: <CAHMBMHxYXGAq1Aaq+4AWzTemxH=h4+5RS-Et8niKfwEX7HC0fA@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4595]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [robertedward0065[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [alexnorman438[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [robertedward0065[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re:Investment Partnership,

My name is Alex Norman.I came across your contact.I have an investment
proposal that i want to share with you of my client desire to invest
in your country.

Your response will be appreciated for more details.

Sincerely,

Alex Norman
