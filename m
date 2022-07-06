Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC75E567DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiGFFoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiGFFoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:44:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADAD17AA8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:44:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso4469101pjj.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=UoyQ8ArbFecypj/W29iwQoYN2Ja6DmydkFOVIi2BONM=;
        b=ejXIdFt/0Ot7sbc/nkDWYqG4MKxP4yemLB+aEb/QDdOSOHFTnQF1btEPEfa3+3vUnr
         iw3NMck/TFstMn/veLrueW81ZbqOHmE2ewByD4SN1EnuTdrUA/1Q2HhNXZPmR5HvH9lR
         WdKXQB+cgCUfrMr95gLaqnRiV1ngHnJ6SNubdR0jhAnOo14PWSa2DmZTbCZ/NKwEt/Lq
         Rz/6NRduqf1C6QP+ibLevyYw0TnEnjFzLkHx94q0ypQim7o/H2+gRMtQaiOEDuz1tX8O
         +V8rGw14sXMphj4jpzwPFmvKTpQdfbQeNgdpHc6wxLyRk0fymiqnNhZJBd2eHUKSRVr5
         X1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=UoyQ8ArbFecypj/W29iwQoYN2Ja6DmydkFOVIi2BONM=;
        b=7ctDSv+Q7Bpae9iZcQpPCNjExtjSeBPYk7oZUhctYD9ITTElV7MklTtMaJoaNGrclH
         S5jEuoM2DnWE/ESrQ0+cTqrXfVimTJ4xU5maH5FqDPO9aYcOOVBa95sPAgsRTTu/Dp1i
         NoDS5+wAvB/Rs14dlITJ5fajRPp61Sh+bNeOJMzlJVigdNw4b7vygUS9zxwJ1W/F/4kn
         mGAquGgIP+G3X73rtw8tJkZUj9M84Y3blyw8VuJLEQkmBn1yES1VAkjJK2Ot/JBDTchn
         bDwx72THNnXf/3sFPb/hEoaXZTT2O85lP7cuNTLjzd7ygomvaHeuwhQOEpHaM2rR2kVT
         dVhA==
X-Gm-Message-State: AJIora/v+eFFhaRHSBuk+bQLonvrJ6W4juqHcb53Ww16GAKq6dzvC6jx
        PQjp7mR6V7of0v4hmKoMvNmMT+RvIZddYTUijtk=
X-Google-Smtp-Source: AGRyM1tFkRV8utUT17soWv95GlpfYpaSmHFo/pu+JymvT7m40zSoEwGm8A7a76zzT0r9QJLe7TwazjPZ9XHKU1ubepE=
X-Received: by 2002:a17:902:d2c5:b0:16a:5204:304f with SMTP id
 n5-20020a170902d2c500b0016a5204304fmr44598100plc.98.1657086292984; Tue, 05
 Jul 2022 22:44:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7301:3c8f:b0:6a:e15f:dedf with HTTP; Tue, 5 Jul 2022
 22:44:52 -0700 (PDT)
Reply-To: serayahmaalybob@gmail.com
From:   "Mrs. Serayah Maaly Bob" <serayahmaalybob@gmail.com>
Date:   Wed, 6 Jul 2022 06:44:52 +0100
Message-ID: <CALFpWprN90dQv5Fk3nH6HHdMH+s-zw=pmLLVd2HtrTR0Q_WW5w@mail.gmail.com>
Subject: Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I was wondering if you received my email a couple of Days ago?
I would like to have a personal discussion with you. Please give me a
quick reply.

Yours sincerely,
Mrs. Serayah Maaly Bob,
