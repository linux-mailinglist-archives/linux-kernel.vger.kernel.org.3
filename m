Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA45958CF7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiHHVH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiHHVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:07:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00713D19
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:07:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z20so11128037ljq.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=LDaD5tpEODPrwZDwtbGFpYdhzapX5kdN5qHGHLnaQ2Q=;
        b=bpJYP8ykyJag2TvwWquhJXiYfi/90wD/ZPg+psq7RsL4ia8nkMySQ/tVBnLKM3su/W
         fIF1nlTKaF4zQpwRdBew2QAE0Dhg35idlRv5mtXMteKIKfTaL953fru3TY2fYJSGi3qP
         yhyW7AsBbH29s7TIdhRsjk8Tgz3o1/WloiK0oxSVB8jK8MnLGO3WuIBEhdsPzsfmK2zm
         GFs0fesTvvf/26q1duYBrOne7yUFVLSsiWXL0hb5AV4Z1KfNWdkIyHHwS4yN/14C02wS
         NCyagyiJ0b7zxM9fGtiFEhIR1RYyqow6tiJLwVT/TY++66cUTtEjaoQL2Piq3uN5a+0i
         gBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=LDaD5tpEODPrwZDwtbGFpYdhzapX5kdN5qHGHLnaQ2Q=;
        b=Qk8mBSVpbj0a4Q/P9iBJOnWkjNEkjJoftLVUY384K3lz//z23x43JoLOODG6XSxWuy
         a+KSRfWL6qEJeveoMiYfQWE3OsyG9kGJro5fol9o9UwbRo9wufP0m+H9hcWrzByT+cwc
         hP+R5y3L2Puw6BbL33fkl1gY/bblaRbNbtaNXILG3jcN/diUWaivkbQCMPcwAy4Yqd88
         z0QiPgmvyv2pBZ3QxyuBvHdoXSBUf5P/x6ReYDDiBPkefJTV11a9h1sd0HXnfD0JIZzG
         /G9OCmNdofsaT27VIdOa62M3JHaAxAgpI7RJqD2xOFu2c2SaNR7yUfv4GOaIVe7WUgIC
         XMtg==
X-Gm-Message-State: ACgBeo3+2kXIFLyC2HMJmENcBcsjKXIhzJgwFhqt7u9OhmjXc1zAVPAK
        TwEltstHg49ZLRAFyeB4YdwVoj1FQcH/BaiKxLU=
X-Google-Smtp-Source: AA6agR7y2L0NFUK7v2mSeda25DDbGwNppSV4Kns8A1LafcXXqUqsnHsiLPg9W22LR4isdoPDj9UGYiJWN+KA1+k697o=
X-Received: by 2002:a05:651c:907:b0:25e:7957:17ff with SMTP id
 e7-20020a05651c090700b0025e795717ffmr5064915ljq.64.1659992841739; Mon, 08 Aug
 2022 14:07:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:40e2:b0:20e:8415:9534 with HTTP; Mon, 8 Aug 2022
 14:07:21 -0700 (PDT)
From:   UN Asean Relief <un.asianfundrelief@gmail.com>
Date:   Mon, 8 Aug 2022 14:07:21 -0700
Message-ID: <CAHZZ4zqO8uC-X=BW=4M-XJWF7-Ew6_6T8EStCN5jC5RhV37vpg@mail.gmail.com>
Subject: Congratulations !!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You have Won US$370,000.00 Relief Fund. For details and claim, contact
us. Quoting your REFERENCE NUMBER:UNA/GA29/54022.
