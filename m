Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235F653D986
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 05:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348952AbiFED4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 23:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348645AbiFED4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 23:56:01 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2C4DF55;
        Sat,  4 Jun 2022 20:55:59 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id r71so10359461pgr.0;
        Sat, 04 Jun 2022 20:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Tbug5oxO3w7cfAuT7IR8QZhAMgiDjl8V/t3Gga6ClPU=;
        b=YArvzNQSpaZwUX5QP4RREYZ9Nn0KtKz93aRQVu+oSU0nPNj5wERJF0i28lFdt0EaNa
         Lgdw2uopILJwxNYpmgmtI+9f6grJotga7vdXJS9V/r1bnj30SpnlG3WtBIuvd807y9XI
         6r5tDsBigpN9zvePus6CgDhH44fOciQ+tBWW7iR/wpw4aPAJVZTHTdBHrBSGghyOCN/c
         M+8hfDr6QQbyp/fKJESO1ut42hD1+tA43WsAGLPFzR85W0JtlhqWAVSc+M/vaq+ozHwm
         h00hJsq2uq1jrz4nKinxarYejMNpUn8OLNUFugDaCrI23VgVGvIMvT+vV76Ac0tXuSl5
         E72g==
X-Gm-Message-State: AOAM530cTgIznba/mhBv90mYFMcQM7/NgetxomVdB8gXFU9pL7ac75+Q
        ACN6ODD5dFX+OHj102sWfw2G1dz8sdgxUg==
X-Google-Smtp-Source: ABdhPJyUEr1UvBCzDHOm4Ja/FtIK0g3b7VToW6poVjtInNEAt77NCCowqvHpEJYfZZKQgJy6H9E8Vg==
X-Received: by 2002:a65:4c0c:0:b0:3c1:5bb1:6701 with SMTP id u12-20020a654c0c000000b003c15bb16701mr15508715pgq.136.1654401358976;
        Sat, 04 Jun 2022 20:55:58 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id o19-20020a170903009300b001620db30cd6sm7859615pld.201.2022.06.04.20.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 20:55:58 -0700 (PDT)
Message-ID: <a4746c67-fa74-8af1-3f2d-7853e9fae8a6@acm.org>
Date:   Sat, 4 Jun 2022 20:55:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
To:     Avri Altman <Avri.Altman@wdc.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "a5b6@riseup.net" <a5b6@riseup.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
References: <20220525164013.93748-1-a5b6@riseup.net>
 <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
 <DM6PR04MB65752422396C86EAD4591701FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <a7f46ad1-6d9e-a38e-31cc-29fddfa2b496@linaro.org>
 <DM6PR04MB65751A3B1D0BA4467CADDA93FCDF9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <DM6PR04MB65751A3B1D0BA4467CADDA93FCDF9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 10:05, Avri Altman wrote:
> As a design rule, sysfs attribute files should not be used to make
> persistent modifications to a device configuration. This rule applies
> to all subsystems and ufs is no different.

Hmm ... where does that rule come from? I can't find it in
Documentation/admin-guide/sysfs-rules.rst. Did I perhaps overlook something?

Thanks,

Bart.
