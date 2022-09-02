Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7F5AB175
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiIBNdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiIBNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:33:20 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550761166ED
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:12:21 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eb44f520dso4525934fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=gmdL/9E8RKCZY3/6XIPsARXShhqjATenqvCYhDjutDw=;
        b=fDxJqz354nPZjrFWEZvxasZ0pqQ9f4ED5mWuBcRs5+K/8q4RWLo5ewpTJDhc6kWJJC
         UnpringxPxOc/0PTfCNC49RjaxdN1uKMrR+o8rOJebkgFB1VlQIZeISKACBzkZN1ST7D
         VykSM9r9tbcS2MNGST1Lp2kOqhel0MbJtT+T1ElrQQcwTDR6k7wgPVbJNfdyn2Wri6VW
         9yoKvl1T5iw40Y6HWFnSTH5hznzbyilOzvE1eJNuyFywvMY2L63XUV4nNgk91fTGEEfP
         UK2HKOqcJ69zMRV8lKFnJ3ZyHiwE97RUys5uqMk6+vLQeu+0NBXtlsrtwLNT/bIe964I
         qp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gmdL/9E8RKCZY3/6XIPsARXShhqjATenqvCYhDjutDw=;
        b=BxoXH9wP83YAcCSb+doO/ZjNeG0V0UMwj+6I7SDgFX0m10jnzfA9L+65k2oYhHHlEO
         Om9arAxtxrAviS+Xk743O3AGEnf99bOIhF8dbUguW08oNRtu+Rgv/XJjEA6pVgOdats+
         qaJtk5JD7sI6Fk9FnbqzV61GQQivuKimHOFH6mRs1t6TDSjyMnZuPlgb+MJ2poGGaJfH
         sF0ijUhCD7crbc0PR6rF0bAuK8easa7l3J7+u2txuTiiSb2oTsTXPyV1FplkgkKfT8xZ
         TQ1pLdsrd6S8loMMTsy0xrExd5A10snfoxzKD4ug4ckxFZTRiaJMosIcsmgrzg8vvNnP
         d1AA==
X-Gm-Message-State: ACgBeo3tVw3VO+7A4K3MQcpkVR7pzkBwYY8iLzWk24nILQXSndJK2+0Z
        dg/R/BpkoH/BZCxmB++AnlU26ib8xCZluoaUSBxglPF5alfKDhM=
X-Google-Smtp-Source: AA6agR73D8jnOilzyk7gYHHv7RMhhp0WZOk7c7EaO7+ZxfmdqwDS3beQ/25qMCvAtibS+FEI7ml5ezkxVmES2bkr+PM=
X-Received: by 2002:a05:6870:6015:b0:fe:340e:e854 with SMTP id
 t21-20020a056870601500b000fe340ee854mr2138285oaa.52.1662123783992; Fri, 02
 Sep 2022 06:03:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:9acc:b0:b6:1172:b2fa with HTTP; Fri, 2 Sep 2022
 06:03:03 -0700 (PDT)
From:   Noel Quinn <goodhearts66@gmail.com>
Date:   Fri, 2 Sep 2022 14:03:03 +0100
Message-ID: <CAHtpm_SV0i4XZmx1QfhV6OAG5wZBbSEezA-d27TA_V6V0jUomg@mail.gmail.com>
Subject: NSD8=W3
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am Mr Noel Quinn, a Banker and Credit system Programmer with ( HSBC bank ). I
saw your E-mail Address while browsing Through the Bank DTC Screen in my
Office yesterday so I decided to use this very Chance to know you. I
believe we should use every Opportunity to know each other better.
However, I am contacting you for obvious reason which you will
understand.

I am sending this mail just to know if this E-mail address is Ok, reply
me so that I will send more details to you. I have a very Important
thing to discuss with You, I look Forward to receiving your response ASAP


Noel.
