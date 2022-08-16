Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4134596160
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiHPRok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHPRoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:44:38 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC927A743;
        Tue, 16 Aug 2022 10:44:37 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id d126so10850225vsd.13;
        Tue, 16 Aug 2022 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fyBpZx17POe0IWvyygwEd4I2pv2A4jN4S+7DSdDHB94=;
        b=PYr69wP9biG9a12s2MhSL1ThekQKS1VcDLnrZ/rizWErjGZ9cya+6jhLT6JculwVXt
         8Emlkpx/C2yGmnQNg+WX/Y3rIXe+dN/MCzVQOwRwPFvtNPBGvhjJ3nxvXFyHRpIAIcbc
         I/YhfF/9LP5/G29Z7AqdktMQgGxqCS2FT+OjQS5gNAEK0vqK3I0ULqHMSKP29lCzjbCU
         1jmHQ88W+AHuOZs++Ju7Eu38NUICCdf230OdGmctKtvIHm+50xMw3sSZfIY6HcYRMakv
         ZDPk8BC0zzSO+w0Nxa579iIW7xSfnlszMlSUTA+yJc0rs/s1ZHUrrJAfCvfCaKTobdyd
         sAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fyBpZx17POe0IWvyygwEd4I2pv2A4jN4S+7DSdDHB94=;
        b=XNSlQHEbLTOs/syoTPF/pUHSSMfTFpJGlBbM2SwZYgtmg1vetfNcyhJQQCy4sEV2Ns
         Li0/qDeU9EYTaNZJLJzqkPz+e1qUmmaxh6UooOxq2TudyrURHPrP2TXyEO2AlzXitI1V
         ZeIvY2QN7eFaBNuGgXCRz1SgVh+UfQpRA8D0UoM6HsrJVaqSJNd36M+63Ex+Q4HnBHKU
         +5aOdH/Udhp7klbsHjiN0vOtHub5TSlA5Ugo90MFfLXI5nCX/eyQXRtUBhIr94xH7QEL
         ux0+xBbxYPRyjhjmrsELPThxI8Aqydc5F61Nrsak5OZfExEM5ciTIOgBSxsQSV0lPTUT
         kV7w==
X-Gm-Message-State: ACgBeo2OFSRa8O8r/E6BcECFLRP4lTsVktcmBK6R4iZR4QMsTpSOxjhY
        I5sDfrQTAL1QKS/SJWys8o0=
X-Google-Smtp-Source: AA6agR64weW8q+6jGycK/7hg0Kqi6hxNMUNXxIqKFgWA1ZRFJHn2gn4q1san+FdnWvrp4eqiP8u7iQ==
X-Received: by 2002:a67:d21b:0:b0:388:4e12:eff9 with SMTP id y27-20020a67d21b000000b003884e12eff9mr8845733vsi.35.1660671876074;
        Tue, 16 Aug 2022 10:44:36 -0700 (PDT)
Received: from ?IPV6:2804:14d:72b4:8284:19ed:f36a:47fa:2c31? ([2804:14d:72b4:8284:19ed:f36a:47fa:2c31])
        by smtp.gmail.com with ESMTPSA id n65-20020a1f5944000000b00378fe8518dcsm9110810vkb.51.2022.08.16.10.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 10:44:35 -0700 (PDT)
Message-ID: <ce2a98bf-a8c6-c666-b7b3-c6c97de0e23c@gmail.com>
Date:   Tue, 16 Aug 2022 14:44:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in media_entity_pads_init
Content-Language: en-US
To:     syzbot <syzbot+47c70875ed0bc4fdc9f4@syzkaller.appspotmail.com>,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
References: <000000000000b87c4405e657a415@google.com>
From:   Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <000000000000b87c4405e657a415@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will have a look at this issue.

-- Daniel
