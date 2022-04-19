Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729085060FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiDSAkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiDSAkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:40:51 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B6D27162
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:38:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a5so12086938qvx.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=uiFoHM8fg7GA8a/WXLByn0nuswD0G/yVMmEm89BScm4=;
        b=d5PTFUU1nuAE659Hd/r+dPbro1Dsu1FpNYFqg9BqrI5Sk5xeq9pYqe1g8rZ6S8aaaK
         iSoCy0/I2dq6z6laMklNO0FOorVrhNogXF90P43gr13SXULxX13H7vaoxSKofxjsq708
         y3MZIJDClQTxNG2ogPz1X91f3Ez9n3bDMbZQt7XSyuzgJNpUTdGvtf16jydEL2XmID0J
         YczUq5+TOwxo+QqiKColq8ILIFLPmspXx4qs4ABkDEU5YbSAvTih96D4vzVES7zIe8Fy
         DUxnyBdsqS+cajxrN6I2liLUnFaAB2S+mSKcBqJTuFqe/ULAHD8z6mmKAqYBl4fRlLD2
         ZOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=uiFoHM8fg7GA8a/WXLByn0nuswD0G/yVMmEm89BScm4=;
        b=cp+FdUgFyOudR2iSKV4Z7SOWUywMg/o+C0D37v4ppxAzKkhh4LqrDL6qG4ka7Rc+kF
         Dk+rBPrlyRYQXKjjXruqssTBFtvNNkqmbSJ6g1hrv7EI6ulwCuvmAhdLqdT3eZQaWJQS
         haQ7Llv+2mORmDFHAdJjIQ3uskVJAyKH1jMEMgG+QkHN0C2dl9T/H10bzvujUO4lYe5s
         ubunTfWA2ZUVIct8CiRf4TxoWRvyyxcsTnFAi0ic4mtWDT7ChQQBftquOroPq7e1Agfe
         /vYVB62cqhkQkoc72EgRBimaI2g6aVnyyYCx2VB29BPVFXnzsdDF3JCSUCrl7fPceUDz
         6bCw==
X-Gm-Message-State: AOAM531wi73xJUF4JHvdWcJatei68t11qhEFnR3NpdznkBhpFK+RSrMU
        6ZNBjtxX/yxmTuRc5RbH2jeZb3JwqiM=
X-Google-Smtp-Source: ABdhPJzwm48wylBwimOWVl55dmWEBbiBMxo3m0f9gmq0b3YAEVHJf+INXSen0RsSoKPyrW5BJU/7mQ==
X-Received: by 2002:a05:6214:20ac:b0:446:20b9:f918 with SMTP id 12-20020a05621420ac00b0044620b9f918mr9821142qvd.126.1650328688365;
        Mon, 18 Apr 2022 17:38:08 -0700 (PDT)
Received: from [10.1.1.117] (pool-71-121-149-202.bltmmd.fios.verizon.net. [71.121.149.202])
        by smtp.gmail.com with ESMTPSA id h27-20020ac8777b000000b002eff87a2c42sm8376624qtu.4.2022.04.18.17.38.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:38:07 -0700 (PDT)
Message-ID: <ffb3b044-f38f-c35f-ebbe-4e89aab0f38f@gmail.com>
Date:   Mon, 18 Apr 2022 20:37:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101
 Thunderbird/100.0
From:   hanasaki-gmail <hanasaki@gmail.com>
Subject: kernel wifi + BT5.1 chipset : AMD Wi-Fi 6E RZ608 (MT7921K) : wifi
 802.11ax support
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel wifi + BT5.1 chipset
AMD Wi-Fi 6E RZ608 (MT7921K) : wifi 802.11ax support

Looking at the below motherboard.
What supports the chipset wifi ax and bluetooth?

What is the first kernel version having support?

I see:
   /kernel/drivers/net/wireless/mediatek/mt76/mt7921/mt7921e.ko
but not the MT7921K
also checked the 5.17.x source

ref:
X570SI AORUS PRO AX (rev. 1.1)
https://www.gigabyte.com/us/Motherboard/X570SI-AORUS-PRO-AX-rev-11
