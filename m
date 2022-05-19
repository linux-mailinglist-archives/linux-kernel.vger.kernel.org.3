Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D140B52D0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiESKxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiESKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:53:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66CAFB02
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:53:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y7so7663271ejr.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SK+ZQhQjilCrwQiRCpsWW9SDhndydoTzucLtlj/VLJc=;
        b=gPIiWaFYgShLcBNU6N4flDdxJzPgUZ++17C4r8wwXZxZVaoYGDI3Q9KOb3A1dp7oyR
         WCH5RJimd9ip29sBifwQpQGsHcexUO6P5Rh0MAtOzz+CjN6p6jU9Zx0MUcz2Cr8OBv+0
         tlZVPqKkZnKbb+h+lnTFuG+bkdfFELAt9mo7XS4GslhjC+vcY9zm6EuJfTZVf7WHUNqZ
         Im9olXK9DuB0H8BVCUy/fwGPz+fKOKijEX92ZHkneuiObgP5g6E7dRYiab/fV9amEsYb
         Ioa+wSR4Y/Pu2oRK3NXWdDzpPKN6XtIqkn/xTd/EhZJycda45TIczaQUqbYqVIIZ8EyJ
         bUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SK+ZQhQjilCrwQiRCpsWW9SDhndydoTzucLtlj/VLJc=;
        b=fAiUx5Bx5uKhJL/Yxawiz7jHbk/IksD1rjoveFbjyhJJSNOTGfHCgHL0oE2nVzfFyR
         JqIZJhlX41cSoLs50BRDJAKTJ5CNcqPYnW18E46BlFg/nnPUCIx8HYe84ALsQo/Xk+fw
         HacMy+O2IMiSmA1HFeRt1RY/mjuh5YdwihXERnT3ILU3YzhGo6mFRBOid3fNpBBY8/IL
         uDjnvqi2xnUQePMme1/isC/ColIogXWOG3EdbvGFgjbqidbDeuDz/J+rZhgFP3kbpZ4T
         4P1z7i7VMJI1ylZYxS3AcYmcMcAv3mYIG+pnn9VDmxPcmO77ptdZS+cLfACWPikV9VE5
         cwHw==
X-Gm-Message-State: AOAM531lrGnwX7NYEP77k9YlrYg/Uczn3GrK3myErLkUrdYKwTI1S+la
        Wq2xmopPk3XIoTKutmt2mCpl8IqwTh9M899sjuE=
X-Google-Smtp-Source: ABdhPJzdTcii+fZ3sVi/0raDZzgVGD3p4CewWGhCev/gM64DynkyaJWeEnS+vfzZQFZVqbvGzbp3AXGpccaAI0b3KTQ=
X-Received: by 2002:a17:907:98c4:b0:6fe:a1e6:eae5 with SMTP id
 kd4-20020a17090798c400b006fea1e6eae5mr87838ejc.309.1652957579309; Thu, 19 May
 2022 03:52:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a166:0:0:0:0:0 with HTTP; Thu, 19 May 2022 03:52:58
 -0700 (PDT)
From:   Ajafor simon <chambersajafor1@gmail.com>
Date:   Thu, 19 May 2022 10:52:58 +0000
Message-ID: <CAJJ9-BDPvQcLtxqhG3BFV7YG4M+dHK8u=CRDOZpYoghqu8CMTg@mail.gmail.com>
Subject: =?UTF-8?B?5Lqy54ix55qE6buE77yM?=
To:     chambersajafor1 <chambersajafor1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Lqy54ix55qE6buE77yMDQoNCue+juWlveeahOS4gOWkqe+8jOaIkeaYr+Wkp+W+i+W4iCBTaW1v
biBBamFmb3LvvIzopb/pnZ7mtJvnvo7lpJrlk6XnmoTkuIDlkI3ms5Xlvovku47kuJrogIXvvIzv
vIhFbmfvvIxHZW9yZ2UNCkh1YW5n77yJ55qE56eB5Lq65b6L5biI77yM5pu+5Zyo6KW/6Z2e5rSb
576O5aSa5ZOl55qE5aOz54mM5byA5Y+R5YWs5Y+45ouF5Lu75om/5YyF5ZWG44CCIDExIOaciCAy
MSDml6XvvIzku5bnmoTlprvlrZDlkozllK/kuIDnmoTlpbPlhL/lnKjnvo7liKnlnZrlkIjkvJfl
m73mrbvkuo4NCkNvdmlkLTE577yM5LuW5q275LqO5b+D6ISP55eF5Y+R5L2c77yb5LuO6YKj5Lul
5ZCO77yM5oiR5LiA55u05Zyo5ZCR6LS15Zu96am75aSa5ZOl5aSn5L2/6aaG6K+i6Zeu5oiR55qE
5a6i5oi355qE6L+c5Lqy77yM5L2G5Lmf5rKh5pyJ5oiQ5Yqf44CCDQoNCiDmiJHlhrPlrprpgJro
v4flpJbkuqTkvb/lm6LnlZnoqIDnsL/ov73ouKrku5bnmoTlp5PmsI/vvIzku6Xmib7liLDku5bn
moTku7vkvZXlrrbluq3miJDlkZjvvIzlm6DmraTmiJHpgJrov4flqpLkvZPmnI3liqHkuI7mgqjo
gZTns7vjgILnjrDlnKjvvIzmiJHlt7LkuI7mgqjogZTns7vvvIzku6XljY/liqnlvZLov5jmiJHl
t7LmlYXlrqLmiLfnlZnkuIvnmoTku7flgLwNCjEyNTAg5LiH576O5YWD55qE6LWE6YeR77yM54S2
5ZCO6K+l6LWE6YeR6KKr6ZO26KGM5Zyo5rSb576O5aSa5ZOl6KW/6Z2e55qE6ZO26KGM5rKh5pS2
5oiW5a6j5biD5peg5rOV5L2/55So77yM6L+Z56yU5beo6aKd5qy+6aG55bCx5a2Y5pS+5Zyo6YKj
6YeM44CC5oKo5Y+v5Lul6YCa6L+H5oiR55qE5aSH55So55S15a2Q6YKu5Lu25Zyw5Z2A5LiO5oiR
6IGU57O75Lul6I635Y+W5pu05aSa6K+m57uG5L+h5oGv77yIbGF3eWVyc2ltb24xQGdtYWlsLmNv
be+8iQ0KDQoNCuacgOWlveeahOelneemj+OAgg0K5aSn5b6L5biIIFNpbW9uIEFqYWZvciAoRVNR
KQ0K5rSb576OIOWkmuWTpSDopb/pnZ4NCg==
