Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E26528321
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbiEPLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243144AbiEPLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:24:26 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2976C38BCF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:24:15 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c62so15118214vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=v7/xR8YHxvtEWItoGCcgyQFho9j9XpVaXw2jIxKf7To=;
        b=OhVqqpLAbPXjjKDWmVRAFa10mRAob2fdAzcqWV9zrJxwX0LtPuiRLxizlgUp/8TXJ1
         iI4BJzI0SN0OnaIC9NeWY61sOf2wEJjp109SfcJRaRGsIGPXesbZf/Mn8I49tfqPSZwA
         62PgTVLOlH6OaeG1TJUHcAtRuyGHJc1xryV5ISyIQlJMwvjtAc1HqwynHKP6RufVyO2e
         BWylSCD1T+/oall7nxOws7qbB9hkTwGR1mS0JtZ2QyDkbyxyYYjoS8gJlgFKC0bxwrO0
         Dh9wbTgZ5YlwENnJSbAXKvnYqiHbvAtX6KkkPrw1/9wlxbzJq+g1ZLR6C62A1C9mPv2E
         brtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=v7/xR8YHxvtEWItoGCcgyQFho9j9XpVaXw2jIxKf7To=;
        b=kdoEe+oIsFALbETszvteVdCQnoocCW0bKnFw72jYWz8ld+eE/WEdCMhBfXuXRu+a2G
         RKdEE8bn7Oc0kPufCJviz/8PBjcNwKGbjNfEdKGjEhG34JZtusqD+7/i5X0SWAPPQrRp
         m6rz5HeoRiq0n0rBDh9qXhwEaVBhc3/++02LOnJOVdS4OLjda7f/7HljtuqwP3/yUTeb
         /mcB7XN5BPsivly/+K/sUMdwxUNXYcieH9MUkAzofD5KBQ2xRCfIEN1d+vr37J+7aZHa
         87M63YUO2I/1bC82ZEh1TACBiGlVKTJBaUWCsGfVLxEGXf1Gj4X33pT4Sid/lDVkh8DX
         BMPA==
X-Gm-Message-State: AOAM533xPbhbCOrbeLRjOD6DEklM7EIOgx7F4uqxCErgl08yuRQofwyr
        HMNaOwc2N5z+4Un75GGmYmCfgMd7Btwy9VhL4Wo3yZj0jIk=
X-Google-Smtp-Source: ABdhPJxkIBetGFd0fncG6WKgWZs3V56KjTj8J5gyeBHu4WJLV6uqy/olLyY+JsHfGq/FEQ0QkCCHn4QZuOMU3+giNsM=
X-Received: by 2002:a67:f5cf:0:b0:32c:c4ed:12ce with SMTP id
 t15-20020a67f5cf000000b0032cc4ed12cemr6010687vso.27.1652700254335; Mon, 16
 May 2022 04:24:14 -0700 (PDT)
MIME-Version: 1.0
Sender: ibrakabora135.bib@gmail.com
Received: by 2002:a05:6102:2050:0:0:0:0 with HTTP; Mon, 16 May 2022 04:24:14
 -0700 (PDT)
From:   Mrs Vivian Thomson <viviatom02@gmail.com>
Date:   Mon, 16 May 2022 04:24:14 -0700
X-Google-Sender-Auth: ErnEgpdpqeHr8Zr_hsXn8pHnP0g
Message-ID: <CAPQQAPHnCB=_=WL2hNRCpPcyJ4AgBgns7uDz7wNHk2_=i7MiPA@mail.gmail.com>
Subject: DONATION IS FOR CHARITY AND NEEDY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,UPPERCASE_75_100
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MY WARM GREETINGS,

 I AM MRS VIVIAN THOMSON FROM FRANCE, I DECIDED TO DONATE WHAT I HAVE
TO YOU  FOR INVESTMENT TOWARDS THE GOOD WORK OF CHARITY ORGANIZATION,
AND ALSO  TO HELP THE MOTHERLESS AND THE LESS PRIVILEGED ONES AND TO
CARRY OUT A CHARITABLE WORKS IN YOUR COUNTRY AND AROUND THE WORLD ON
MY BEHALF.

 I AM DIAGNOSING OF THROAT CANCER, HOSPITALIZE FOR GOOD 2 YEARS AND
SOME MONTHS NOW AND QUITE OBVIOUS THAT I HAVE FEW DAYS TO LIVE, AND I
AM A WIDOW NO CHILD; I DECIDED TO WILL/DONATE THE SUM OF $5.8 MILLION
PRIVILEGE AND ALSO FORTH ASSISTANCE OF THE WIDOWS.
IF YOU KNOW THAT YOU ARE ABLE TO RECIVE THIS FUND DONATION AND DO AS I
HAVE INDICATED, REPLY URGENTLY TO THIS MESSAGES.

WAITING YOUR REPLY
MRS VIVIAN THOMSON
