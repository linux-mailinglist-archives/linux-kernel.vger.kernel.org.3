Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55D4DCF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiCQUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCQUFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:05:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AD82BEC57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:03:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gb19so5813067pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=UACvo33S+WxRGoZYppQdqpTzq+gLwRnNnuxJEAcPUPE=;
        b=RN88dEd1JbDEUp8PBc1lJMx7lahrzRVaKoA3YIH2Y371cCZhY0V+sExI5DBStypwkD
         zuVf+FQDytltvnrLvNmpyJ8O+Acw+HUvPajc+l+sgaDHe6utQl4KHtQ1hBH9/4YTGLEd
         LXvjNOff7Ywp3xT23EmON2/Fqg1+AUm6II0UgOwOfSrzkQFarxiZj0yMCMAcRmkkNm26
         9Zf5jZB/1nY3P6OV7Cl3OOXqBHEfn8hVlWIrECMB9LjZahnACUFwnjKX5JkIvMW/tK5p
         uSrU+DA2n5WNpqQye8AB0NEgKFFMJPj/4SD0e8bDlMSUieKqDsOf/44vQM1dLwvoGtYg
         e0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UACvo33S+WxRGoZYppQdqpTzq+gLwRnNnuxJEAcPUPE=;
        b=bNOF2ZQ23yvvBQC21iXhsIgRGM6cOSIYASntLV3XPn8t2sf5JmoXJNYfZekfvwyFPm
         kHto1hmYqboAuq6Y4abCOqf/mkJmZAGoEgwRWbF/tpXc1h9l3CZw38PogesQ4NX+hVLD
         OLAuZLK6n1b96vKggfnqdOvcVWB6IBUlwwLWebZsKIVyniDQ7EwYEEW8vx+B3Q+jzw43
         8GkHoVBq+C+mYd3peVcfZWzMFxVEqWUFXkOf5wFMzHrR8ue6PqcCDX6UKdF1CkmlqYnt
         Rzs1DSKQlbB9FeKs22TCwo3BdzrWhj1LR4t1oxDxq05ruKHOBT+bQeiJmOEWDvjrFPpy
         zpnw==
X-Gm-Message-State: AOAM5310eCX4ZBBaXZZOCT7edzqmhFD11hf2G5uBTPKwlPbDf8XxYx1Z
        s1UIgsLpyas8VuMyfinrvdAKrpkuR1iGDfcV4KE=
X-Google-Smtp-Source: ABdhPJzmNDqztDjZBLIZ7ui+J22FdtRx9fA0IFKzysH/+Ue2tEeUY/Z2KEfxVOhyOr5sFY0OZds/uSD8jCP0r8xI0Eg=
X-Received: by 2002:a17:902:c943:b0:151:fe0f:fee6 with SMTP id
 i3-20020a170902c94300b00151fe0ffee6mr6666549pla.117.1647547432216; Thu, 17
 Mar 2022 13:03:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:682:0:0:0:0 with HTTP; Thu, 17 Mar 2022 13:03:51
 -0700 (PDT)
From:   Amadeo Giannini <mrreeg4@gmail.com>
Date:   Thu, 17 Mar 2022 13:03:51 -0700
Message-ID: <CANh7O=6j3CcMWzXuXcgbTXePpZ8fhpRTLCSx=O8pqN1P8YaKbA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Contact us if you need a loan how much do you need? & when to pay back?
