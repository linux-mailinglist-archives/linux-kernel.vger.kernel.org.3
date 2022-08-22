Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF659CC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiHVX0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiHVX0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:26:47 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95A558C3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:26:45 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-3375488624aso307177457b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=vqzf5EeZAat1+wmU4wlpZ+5i2bA1ORJap4xWB9mjzq0=;
        b=BrDaZ+pCclXAuHXsZV6mssEe+iqokUVACu1f4J4QPtPUGwCnJCyHasJdNGgj1KBER1
         77upn07ZwV5P8hEKJy8ll7ArvmzdTXdNhKlRakMuplGxLOiMuqZ+OclXqh6OEzNIxx5e
         E6Xbm5NMv2CVq1CaSqbt2sfqDr+3uUXt2FW8E0yI+oCcQILqOWupO/pYvbYCQM0ORBRF
         QZnJrELDIr6NlIve83SqiKIHJDwtOnAAqOpQJQfmOOatPgomuqKdklYwUyyTJIX5/wzX
         D12/phe89WS/6tlPzSXL/f+bOCRnzhZ3+h0/b0ZpuFBYxySZqwjcOFhPFjHdqwIWa4pC
         jhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=vqzf5EeZAat1+wmU4wlpZ+5i2bA1ORJap4xWB9mjzq0=;
        b=HkpKNB3MzhSWDmzxxYNoTE2u9uMjx3P2jrVEDrr2NMSMksHUYJQQ5xJjtn06lPTp07
         3Ly9J8str6uS9Yr2p8tMh60rev4NeVLbXO+NjzHRfx1JtcKrUZfsInciUYJ6VX9TE0eq
         WS/ZmdpxLBsuaHeR4nfttJceLnzrLmvVq+rej+tBjdsIEDdODvUGVaHWvDhuxj85FSQ9
         xXMvZoYssMVI3onlOiNsrer2XHWa0mOpq57aDyewwmK2UD4U7GiooHNoKs0h/kgltRkr
         KC6cUVHmCfvOrF/r7t3cQW3k8zZh/BA0mDuLNZpvyoXwGhuBBHbMYQx5BvU0FOWNybyI
         H2rg==
X-Gm-Message-State: ACgBeo1VdCV4fD21f5ug7Lnf/NYUe5iYaJLAaETEpTyC6oSwHr4IbesZ
        6LZfw3WbR7kT814a+ls7leKmKsOW32TX0WmbnpA=
X-Google-Smtp-Source: AA6agR76mloP5voMDFDHP/H7TRephP7hRP5UdXEv0aeWCOiFDEX8Lnjtq21Q+HtmhE5LrW6CglEBcnXYJkD/gRHDQi8=
X-Received: by 2002:a81:6f43:0:b0:335:9e7e:ad25 with SMTP id
 k64-20020a816f43000000b003359e7ead25mr23047209ywc.518.1661210804789; Mon, 22
 Aug 2022 16:26:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:4708:0:0:0:0 with HTTP; Mon, 22 Aug 2022 16:26:44
 -0700 (PDT)
From:   Jerry Dosso <dossoje524@gmail.com>
Date:   Tue, 23 Aug 2022 01:26:44 +0200
Message-ID: <CAGpazX4evm3uA-cFDh7sB3hghDAv+jXOWTVgMkHo4af_HsEe8Q@mail.gmail.com>
Subject: Dosso Jerry
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,
Did you receive the message i sent to you?
Regards,
Jerry
