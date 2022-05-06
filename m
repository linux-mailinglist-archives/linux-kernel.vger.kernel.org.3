Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3F51DF31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354179AbiEFSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:41:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1142EDA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 11:37:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2f7c57ee6feso90854327b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=T5FzwlnwwLPSlsTULB5vVS6qck4pbK33IxK3PwxxGYs=;
        b=NgeYnxUAFa1e7FcRN5HhQdNLEGXsLHTNgvgUZ63qMAaiIWh36THV0BF+P+35aLj8o/
         TieL1hBeUFemkbIjecmmE6fQ1rx9VBLO1o+hTACNjN1oJDzQs7I/FJBIxOKD/xWf7LxN
         N0diL6SQ7pyoez0yGsB93ouxzKuqZ697GUwnv4dVx9VZ60ODTwSJ86Mx4mhwcstFF0IG
         CD+jEkXtdPX9kd4w/N7+CP18X1kdrpPvcanxhzUkfj+fDnpa7TnxyxsHzuBWyWmf+c8h
         b/9SGfIC2whv3HRPFEYgYeInXIrbTfwiHVgCh/CXF8iiDWCfRId8z9vY/dAebKO3AJ4P
         gC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=T5FzwlnwwLPSlsTULB5vVS6qck4pbK33IxK3PwxxGYs=;
        b=d0AQIgJkrSMmp2qIjLVAwDx+Vd1BUtqmb83PJlQS30PqWozuFPnr3HYQVawvDXWs15
         MQnfnqRF5MP44CEGheMrZmjw//7lsDRwAFKkWlH0uVdfAi1GtHPOSgVqxqf5hHXBFCRb
         TNFCQTOba8p2ZYYAgNarj5cs7iExIbiglJcbzy2pjSRGq2mwlQLbFWQs7ZLb+J1gfo19
         vOtU0Gu11XXUIGojMTQbgbmVL53iC+3mfi7qJGhUdiADnQN5aGwt7v0nqa4F68xurHpv
         dWT0kSecH4fjkFNe4NeZwfnFn/fKTZ8HDkHKlFPFfhtqhLNuQTaFAxhXmn2T+jw4v3pb
         B/Kw==
X-Gm-Message-State: AOAM532zvg5tTp6S9J4jom9YUSnFox8y144tk237noWPTUR9imaU1Y9C
        63+D9hYuq/CzU/d3Tl/bemWaJzzZnTGn5a9xxgas6CYw
X-Google-Smtp-Source: ABdhPJxrqr/qEKXhSZlts9ilQviqsFVqIZ7jSL8qCRH7CykbkMatv5auK8xZE9d1Ef7ixb5RvRFXk9o0SL/17US2+NQ=
X-Received: by 2002:a0d:ea91:0:b0:2f7:b6da:87c3 with SMTP id
 t139-20020a0dea91000000b002f7b6da87c3mr3866614ywe.226.1651862264727; Fri, 06
 May 2022 11:37:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:b410:0:0:0:0 with HTTP; Fri, 6 May 2022 11:37:44
 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
From:   Warren Buffett <kosolnakemedou@gmail.com>
Date:   Fri, 6 May 2022 18:37:44 +0000
Message-ID: <CAJWF6CAPx+C2-z_wThMJnd=_Rje5TggyJxR5FTJtmT1WBb+EmA@mail.gmail.com>
Subject: LKML
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you

Thanks
Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
