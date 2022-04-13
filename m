Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7974FFBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiDMQv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiDMQvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:51:23 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C7692AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:49:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so1541692otj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ZG+bzkc77NxUdY3pjQCUMYBFdLgc2WfKP0pqLhCrBPV/xJU58E0kGOxwKXsO06DHoY
         2J9CcjkRW+cD2fVlXULq3DTfK+O3MEwSD4czQYCOGALFT1otCpVoY8FJMATlkmu/7E2q
         +2cxi0Fh8UPIJWQ4INq/WRPame1iCZBewDovUy+iGl573Bp6QPKW6f3udmQ/V07FF9m1
         h6/AAQejHRNULsw3OKmvW+p37C7sdftMfQiqSerLrzWPO2P9Yqa/DECdFecBbxEd1n9m
         JgOKw+q1D+elfrEU7erb7o1zb0QRvJQtpX59iMXgEmZ4Kg19l7sSsnMUQySKds4B5Tvj
         lUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EJ+bDVikLNl4TKqdOfCQGUsqll+u7VDuqUBXqr7i2+4AJCMHCpyW4njNX2HT7V8DWm
         aZcyOvRNEjm/fe6wMuazWH1FoizDiwiD6Z6MZyV1h/kY4NnzGst6K3rqShB/A9/mK7wJ
         A48RYoF3eF89lwe4Ih73X+I6yWQVdXUe2naEjFVvLafn9Nr+kO+5x1L5YOTJSs0XY0Uw
         xoYkpESAzhxwyCMfU1XxFS7IzNyJEZJgKVTyDq/ScVJ1tF7/UglcbRGfmBY8BpIPQCuZ
         PGLCcsort65qUtTsrAIqOOBxtJiRroEggKJ48rYR0JLC7Op3BS+EUCxRUlTBVOdoq9kf
         4Ebg==
X-Gm-Message-State: AOAM531Do3lxWvDPNgUkxQcP3LtKAlQflAzN2zZzLl0yTBrSNAGpA/oT
        nn2hRzLV+a4xEwGux0L9JKbaWui3WPir7rnFdaA=
X-Google-Smtp-Source: ABdhPJyV/p+ZIX/iku7lLqGzLRxnYe94SFjqdLw15kGwahB/b4RZIfadgGuzCkPE8OTwFFIf4js5EMxw+krzRgnpVmc=
X-Received: by 2002:a05:6830:2646:b0:5e6:ddb2:947c with SMTP id
 f6-20020a056830264600b005e6ddb2947cmr7089762otu.357.1649868539825; Wed, 13
 Apr 2022 09:48:59 -0700 (PDT)
MIME-Version: 1.0
Sender: andrewnewman015@gmail.com
Received: by 2002:a9d:5a92:0:0:0:0:0 with HTTP; Wed, 13 Apr 2022 09:48:59
 -0700 (PDT)
From:   "Mrs. Lia Ahil Ahil " <mrsliaahila@gmail.com>
Date:   Wed, 13 Apr 2022 16:48:59 +0000
X-Google-Sender-Auth: GVYBhmdbBF2l2p_Lo8AHN5NwWyU
Message-ID: <CAG=yH-_kNP-WdHTv6mphU2Y=TqQLOzS4J_Q9RSfwM9zLJ6Z0MQ@mail.gmail.com>
Subject: Hello! I have something I want to share with you. Kindly reply back
 if interested. Thank you!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


