Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C346564332
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGBXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGBXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:04:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B835BA1B3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 16:04:14 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3137316bb69so53424957b3.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=sig+azz3JqceByz9Gfv/fKXSt0FCnbVEAmHfVujITsw=;
        b=Zg5mvn88qt2g9j6Xw1GqKZtEkks6Z5dwMUoVnvLcf6+YO6u43FFUfM5h2EQXjZPgff
         7Q2vUFMEFDlLzoFj0YqV6vZwG/lpdNBmpgxJuUapm326BdF/YjURa0hP16fdGkVV4AWv
         X5GRqHUuyaAvRoeYQU0vgjkItztYuuktzA/0wz5UQL0paN6rB423S85JOeYhMQw5yLee
         48e62/oGrCv5jBaKdpHxS7muignVxcsuwQfz0qZxZL++Htme4XdtptG9fIEOO2algyfd
         KPnKzHMVhHHzvrAD1s8tZmLUcswIpszbbXzYbXQBCIr/Fb5dfXxNILwkTiut0uNsdmyD
         bF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=sig+azz3JqceByz9Gfv/fKXSt0FCnbVEAmHfVujITsw=;
        b=DCCPD/kd6Hb5cxcjExbgkH6rM/6kWW7nEwGWCTsDLeB02s8oH2nbE7s8w45MFIKh1h
         uXcFZWMkOZQSxw7k8gOZwAuvWFrA3mFFZTg83ry0r6w56QF914R+cRe98Hzm2LLqg1Oj
         15CX2v1sNplEOUcGqOEsVtsi+hAHL0bP9oN/0FXqha8+WaPGWWWEDcuJ/IRsm8rhfP8K
         6mUAZ37zBawdlvOWBxoNxVny0VY7Do929dS2h+ZQG73+RXUkehKVf3EsRfsQ4FQJO4ma
         pBITQX6j/XGhwZxMd/j/MeOfegqqV9OQ1iNlHiHn//ZgNnCWPP0S5haLOguFiS0U+L4p
         881Q==
X-Gm-Message-State: AJIora+kXl/72X17JOXk8mXcfKE63SSyU0tbUNTXL7hBm8mvFqbuwO/v
        L37cbHdQVWY0U8mT7dmoybUnjsVNXiNGkU6DIwk=
X-Google-Smtp-Source: AGRyM1tchIpSTj1OND8deLH0o3lD4VrnXY/kulUUQL82SZenoRLJUjSgH8uoU75yu97YlePNMKc+HFmFSt7v2fuH0nQ=
X-Received: by 2002:a05:690c:445:b0:317:9fbf:b1c5 with SMTP id
 bj5-20020a05690c044500b003179fbfb1c5mr27034492ywb.344.1656803053704; Sat, 02
 Jul 2022 16:04:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7004:0:0:0:0 with HTTP; Sat, 2 Jul 2022 16:04:13
 -0700 (PDT)
Reply-To: lassounadage@gmail.com
From:   Ms Nadage Lassou <edwigeanassan00@gmail.com>
Date:   Sat, 2 Jul 2022 17:04:13 -0600
Message-ID: <CA+fmO4SA6=OoK0=WTQR7sFgDJnLecrVuYB_z+YFa+Oj_V=uuJw@mail.gmail.com>
Subject: REPLY FOR DETAILS,,,,,,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I have a business for you ,Reply back to my email to have the details,
Thanks for your time and  Attention,

Ms Nadage Lassou
