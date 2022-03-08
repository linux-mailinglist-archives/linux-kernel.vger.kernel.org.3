Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A24D1340
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbiCHJWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiCHJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:22:43 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F141305
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:21:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z15so16823554pfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mozilla.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=R9x4dGb/OP+m50jo9Zd7bkwlic201skjBR/blsm4ByU=;
        b=Iqq3uZImfAabE8231KhtU1fKlLuXqNejUR/P1wtIpseFKQ9HIZWsTdGpP/dTciruJF
         N3l7s9Q7kpcrOaF0YMtdr2OUE87GvfVCyyFCn2d1A0EBDCqZto37CsQUz6dr2ouZ7ZFG
         XxmUW8aqYGkCNkrgCsjl3jxdR6qOhrAzgy8yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=R9x4dGb/OP+m50jo9Zd7bkwlic201skjBR/blsm4ByU=;
        b=POYH1NUagHG3InFstz3jlCkQPyxTdvnwjuQB7cL3QZvZ6535avJrs9g7PJNqqBTQN/
         8F2KDH2NXjy13dlalap5/Tia0kURcjN+VH++c6T5KcMnnkEp8l8xc8FVLEffprD9zgjJ
         2CYO1Dsg4VUH3meWPWpVJmxINgMO5v9Z2/Wy30UVhHrNjxw20/2cH67ydDEmZeFwZ+2p
         +iZzjssgLhZg44mVVTMt1ierrQzafTix6P56SjG0pGZsXztTxj5WjcKlBJT77oLPW9m4
         9w00wojNoZvILrnQIuJxtiG3e5l3AU+bhU1qmtFheUcuIg4nmlREFNYZGctHpLeZzYK9
         66Tg==
X-Gm-Message-State: AOAM531/auj+KAQsYACk6D0mF895ZaIaDz1mYp5/nGz1UA4pbmYiDQrE
        R1/vRlb/yuSd7WynyBWLPpXn6G7G8Em79g==
X-Google-Smtp-Source: ABdhPJx8khNSx4Di5vF0egQdQo1G+7eibqmhZ2nVQvc/yJBwAN51Nq7M2yiOZFmEBTfHo5w+/WoXSw==
X-Received: by 2002:a63:235b:0:b0:380:5d91:6cc with SMTP id u27-20020a63235b000000b003805d9106ccmr6472645pgm.183.1646731305740;
        Tue, 08 Mar 2022 01:21:45 -0800 (PST)
Received: from aluminium ([159.196.16.104])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a024700b001bf12386db4sm2093234pje.47.2022.03.08.01.21.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:21:45 -0800 (PST)
Date:   Tue, 8 Mar 2022 20:21:41 +1100
From:   Paul Bone <pbone@mozilla.com>
To:     linux-kernel@vger.kernel.org
Subject: Scheduling for heterogeneous computers
Message-ID: <20220308092141.GF748856@aluminium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Are there plans for power-aware scheduling on heterogeneous computers that
processes & threads can opt-in to?

Several mainstream devices now offer power-aware heterogeneous scheduling:

 * Lots of ARM (and therefore android) devices offer big.LITTLE cores.
 * Apple's M1 CPU has "gold" and "silver" cores.  The gold cores are faster
   and have more cache.  I think there are other microarchitectual
   differences.
 * Intel's Alder Lake CPUs have P and E cores.  I'm told that the E cores
   don't save power though since each core type still gets the same work
   done per Watt, it's just that the P cores are bigger and faster.
 * Multicore CPUs that offer frequency scaling could get some power savings
   by switching off turbo boost and similar features.  They wonThe work/watt
   improves at the cost of throughput & responsiveness.

I'm aware that Linux does some Energy Aware Scheduling
https://docs.kernel.org/scheduler/sched-energy.html, however what I'm
looking for is an API that processes (but ideally threads) can opt in-to
(and out-of (unlike nice)) to say that the work they're currently doing is
bulk work.  It needs to get done but it doesn't have a deadline and
therefore can be done on a smaller / more power efficient core.  The idea is
that the same work gets done eventually, but for a background task (eg
Garbage Collection) it can be done in a greener or more
battery-charge-extending way.

MacOS has added an API for this as:
    pthread_set_qos_class_self_np()
    https://developer.apple.com/documentation/apple-silicon/tuning-your-code-s-performance-for-apple-silicon?preferredLanguage=occ

Windows has:
    ThreadPowerThrottling
    https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-setthreadinformation

I'm not aware of anything for Linux and I've been unable to find anything.
Are there any plans to implement this?  

Cheers.


