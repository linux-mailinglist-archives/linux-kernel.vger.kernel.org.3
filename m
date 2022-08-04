Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38558A3F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiHDXhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiHDXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:37:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFAA70E55
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 16:37:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l4so1390869wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=bo2XBP67BuG05EPFv/XoJIdVEPLxa1771zsCCTAejlB5sRGBBJscipwNLbZSExpHaj
         pUyKO8j/8PL7bynEnTgIAfFfO5K7kE8SGUNCahnQkTvPNNs2NqPrlMjL+jGU6tqcn8Rr
         A/uSn/rVR5Iu09uC/vIuAEyZWqqBuJmPhdgTDpmQg7LcGzOoKz8YVbV26QOS7ffG0IIx
         8/fXPOKXG6S+ehx0Nsw5fiMFEQ4CGeFzBxo5ytpgvK6OynC4YtnkE0s+TZRo5vzbvQqY
         zpBeWRiCfpL0Ol54u9tRq0gBY0fHGFZvmHpIN8HBVco2JTUPEFgHVWy3oXKtNjGfnyiJ
         KxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=2HYVepk841JvJqGX7bY6Zv+Cj58hSrS8wUM+g9ebPYY3rkriBx4Kz6cVMcsdM0aQya
         g+i6ZvHINRJwMQJWj4McxwQfysTxJkpxzEe0vrMRbneJw6NJFWbWYkxOKOk4jsG73Snw
         bAN4GdRhpWitBFAN/TuqDs0X+fAvo3VMPsGua3SxwBihOnG13K8R7t5SH4R0ySoCGgyM
         ALj34Orfb7WJfl/KmSu3SusWB47Bb2eFfX/tFrabZ+p98vE/+nw1EthyuZUjemBMwWQv
         vTD+uqY0MeVLUyWFxtVjato6FL+anOlG/X/TDM4rAqtEp9avBpr9KtoKp5Oa278/Glor
         RjWg==
X-Gm-Message-State: ACgBeo3/FkKTgfSO6tMs6KYvBmLfiQkyiRpPO9fZx8DIoOvqoeVwol/B
        XsIJOzv+rMO8qdpr4ZgWHsJE7j96SEceDSdxSsw=
X-Google-Smtp-Source: AA6agR6f0xgcbz/jJiwHDKBEx340iRt7Ax/7tcMvNnzU6SINdVNPCvSm7LlNyy11FxYItH8Y+id8uuWVtbRpODop/BY=
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr2693929wrr.617.1659656240885; Thu, 04
 Aug 2022 16:37:20 -0700 (PDT)
MIME-Version: 1.0
Sender: rasmaneniampa123@gmail.com
Received: by 2002:a5d:6d89:0:0:0:0:0 with HTTP; Thu, 4 Aug 2022 16:37:20 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Fri, 5 Aug 2022 00:37:20 +0100
X-Google-Sender-Auth: mskJh2IMlAJTknsluuWjbZGqJ0Y
Message-ID: <CAKOWe4C3jnyGfgvXxuZShiyykXU0dpGtbmM1qCzjtEKKCyu8ZQ@mail.gmail.com>
Subject: My name is Dr Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
