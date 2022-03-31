Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9EA4EDBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiCaOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiCaOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:36:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB120118F42
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:34:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id i11so23622226plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1XVqi4Ib1eRyRv1oXeeUNUCcAwlXPZRFfU2ywy6AHVM=;
        b=RmkqI6sZ5YtSysRCO7BsHUN7kt1Kq7AfRuhZkuZfwB1oCf/hTwcOMfEqDO/utOQ7Wc
         oZJReHBgFTClL5RZP+00rtyizUBvy5sc24jAT1XhbNUZUp+SkdSEliECZ7wfUm3KMrLf
         2elb2q1BteWWAfXngj1B0Z2Eh/BlHN32x2VdTDSd637RRW0YBEI+W06JAgBRxWzY6d8y
         ndk0yPG/6r8somJuomIPEWH1EHrDxnGMb7ktASmsD/0zmbjx/qKXlmuKHzJ5yPsBo/Wu
         94RpAA4Nv6JK48Qx/10K9I+ML5iVr1VwXbHuYnMe3EyuKTJBcPQmZ4D4dl/O5NPcvKv8
         YC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1XVqi4Ib1eRyRv1oXeeUNUCcAwlXPZRFfU2ywy6AHVM=;
        b=3itxwHZH6yXbrVwoMqn5zloOjMaPj3wY9Z0y4gcgv7ShRW9DEcZ1ZUC/y04ZAz8Br3
         VHrD8yldsGn1/LQfrZ1o3vBPuvkUHrk20qto/M983Wv906EdQm5C8H5XUQGmKISpvha2
         SspgOQHk3htbKP0oIQcsv8soDSol25G7brpdKtVPWUkTtHYoOUjDKwE/FXPq5nFDZb5U
         P2zSnw2tSKA/2/SLTuPJ9lzmYXWlVn2EFZrWaOB3DVIztPiljJYpnrsb2Y4KjPytqHM1
         JBBuQT8nKONq7sjVdJiqmqGlwF4zRuBycfA4khnCBowNAmmYv6GDeivFJmUClEei/lfk
         Z31Q==
X-Gm-Message-State: AOAM530NgZxVipEkOCj+/j9OwWAV8AxpS234t9kFVSysjMohVYrUoff2
        imLHFC9TgeGOfohuOpJbmHGoGBPNaXeUKDgt9gg=
X-Google-Smtp-Source: ABdhPJz5+lPDRKDNE9tFoLcbGF/oJV0JE+ltWs74dd3bgfK0gV4otudgb4akWkrVfBx6muFWq3VTfsiS8Nf8z1Gy1gY=
X-Received: by 2002:a17:90b:38c9:b0:1c7:1ffb:533b with SMTP id
 nn9-20020a17090b38c900b001c71ffb533bmr6586813pjb.220.1648737256226; Thu, 31
 Mar 2022 07:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:9c0e:0:0:0:0 with HTTP; Thu, 31 Mar 2022 07:34:15
 -0700 (PDT)
From:   Eleanor Taylor <diegosandra357@gmail.com>
Date:   Thu, 31 Mar 2022 07:34:15 -0700
Message-ID: <CAPsXh01L0tub37GEpTKJ9p43ari5w5+GB3SGT3O3DewT=OTQuw@mail.gmail.com>
Subject: re
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
Hello,

I would like to talk to you

Eleanor
