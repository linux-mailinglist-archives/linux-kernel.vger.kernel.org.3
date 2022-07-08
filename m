Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B094856BBD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiGHO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiGHOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:25:56 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4229829
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:25:55 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so16291504otr.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=c9GW2l4zFRYgntvIi2KmvfZ+WdTvDkeuO1Qqcokq5Qs=;
        b=W9TjKp9qNniPm3zeIvAm2pxpM7sf1vnH9Bx4aXrhfbLF+TROHbOUrwftMaHclUfmiA
         nCCYevT6TG4Eu77STAzMM9CTxLKOsc+5xcPoChmNMQohGwhJhHqrhOydQAeG4BDhOprB
         SNUMpOgGSTv4jlB7BwwPH9/Ue1ZuWKbRLGetPxPMcrLOWMTSHZ0lPGtKO84456Lx8nEi
         nJ9BAEeJJqjoz2SFIvMkxUxLa5XHw5+fdoAvK1tHa33Qs6TznvpvAfKYjzf+2S95dUrR
         gjLSj6mRGgsLWW0Zu1syDnUk9gCnYXKCotw3+K5r2I1qCZTFzJDJPVcw/047tiEw7xpu
         BY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=c9GW2l4zFRYgntvIi2KmvfZ+WdTvDkeuO1Qqcokq5Qs=;
        b=VKcXPA1TD5Qbc0tj9hjhrQPjgZPrfPpqX/DpgCgKaNCYuBwEUKi8GkgBx6oiKRFWIz
         ctAHtcWlEN9urZ7ZgbQL5tVBedQpAJk9DbvCBfMxnJ8XDR/YaGYXSyIMNg3GseoGZ0dI
         +gQPAnOdGJujNgXDhzb2szd5g1ow25SxS+vdp2FUJMjkym5XmRwhH5KOTkc7JH2Q2bo5
         /iR5gDUzLcRz5nFHMRWgV2wb4zeAnWRXRt5txb+3lqkVzBGmVzs+w21/3xOlLHfyViH6
         oggJJNjvLrUZpK8RKIYqSj/fkSonkYz5N/tbT0qOlSNTW/7w5uJb6jWKDW7D+2o+EnqZ
         sfRw==
X-Gm-Message-State: AJIora+bii+mi1/ca48Wuqv4ZA15fJsDOEjd1ky4wbGa1bEWHpPQ9C26
        fpidZAaS18GwuCSOY5JMI+nHR0OCxuGcTdeaWyk=
X-Google-Smtp-Source: AGRyM1s6orlf23QUkMNDXoO0DG4cxwXSFZSOfe4CGjMDWMoyYLiSuxLODSEycSvjottJxhEhHMZK6jwLGg4N4ZOSew4=
X-Received: by 2002:a9d:4804:0:b0:616:ce0c:2ece with SMTP id
 c4-20020a9d4804000000b00616ce0c2ecemr1664867otf.284.1657290354891; Fri, 08
 Jul 2022 07:25:54 -0700 (PDT)
MIME-Version: 1.0
Sender: kabreibrahim101@gmail.com
Received: by 2002:a05:6838:bd4b:0:0:0:0 with HTTP; Fri, 8 Jul 2022 07:25:54
 -0700 (PDT)
From:   SGT LINDA WILSON <ssgtlindawilson@gmail.com>
Date:   Fri, 8 Jul 2022 07:25:54 -0700
X-Google-Sender-Auth: A5rCfJgLBiT-fQilbX892QI36sg
Message-ID: <CAAbtB7x8VGfWSq46Muz+bHsNaEaS2PZumz+EzCxgSHy4E-WTnA@mail.gmail.com>
Subject: I NEED YOUR URGENT REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HELLO DEAR ONE
   AM SGT LINDA WILSON
   AM CONTACTING YOU FOR AN IMPORTANT AND VERY URGENT COOPERATION WITH YOU.
   PLS REPLY TO ME AS SOON AS FOR MOER DETAILS
   REGARDS
   SGT L WILSON
