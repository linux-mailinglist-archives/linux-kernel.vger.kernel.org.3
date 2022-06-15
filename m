Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16CD54D030
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356649AbiFORkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358002AbiFORkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:40:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5153727
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:40:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m14so609800plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=assj3HkZIP/dP3hc/JsEvBMYFIThWXXtYCLn0ntJB/E=;
        b=kWF41fcl58IEMRYiXWL5UpPsAz6RyViMzBC2o1WVizoDebUxc3Z/l0A23Dz43VZ3XE
         y0TV9CoGX+gvt+imXrAJDyVgy85+Jn7vwoi139VTSd3bro9w/r0rqKpFitneIrHletqG
         P8xfWPjhDGgY12OW2FqQxQYthrK0H0/Hm/szFNyWJwepa9pJdChpsmLk/+ntvGd7HY2/
         AxH77F9ktMDXIVGQLFge/okYRI0cTq3XcK751PPK6o5SeIFcdOFMzOq1EH9kFv28JG09
         9PTyPDYtOu8yiyiI37wrcBQs7jXUTJj6Jw3b7JJ5LkuCpsfdnskkOLxH3Ep3F7O5TezY
         20IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=assj3HkZIP/dP3hc/JsEvBMYFIThWXXtYCLn0ntJB/E=;
        b=XztBbSUxlbq3oN7n9kd0SURZR6HRRbiij/qIvmHHlLKk0vdKuPPBeuFWp/15CiAQwn
         Vytm7GkVevRE4Guogf1s7WlDHeTC3D8NKUuaupLLpfOO8CoDLcRe/gZCs3AKTFIYAzbY
         JRPN1sHha8KgaKO7OvFCcEUota5qctUa/qOkbkNsyx8sukLKU9xvhzBhk1UwvoCNXlAR
         OJwka9JNqzSFK5hluYOnO0UM78b46tLT5vC6/Z7jz+b7H9yhgTwDJuvfe+Axncqezv00
         lUB5w2As0/y94d4DaSezpP5XDn+FqPIkoGVrU3J2BSDWQZgbNJnF3WEUUS26uA2UKKxF
         7HhQ==
X-Gm-Message-State: AJIora/Cbnae28Rz9eRLEs5X8OsWbhZA7YntKFoZ2GWcCviU4P+dFXUE
        UW2m/6wzUosSb8e931U258I=
X-Google-Smtp-Source: AGRyM1u7UDNwl3lIxcFSJqMelMAeDJ707xpxzRAK1PfE8BZbMmAmIUmS6c4rLTdLmNdvUbF2njAGmg==
X-Received: by 2002:a17:90b:1b10:b0:1e8:2966:3232 with SMTP id nu16-20020a17090b1b1000b001e829663232mr11444760pjb.103.1655314820166;
        Wed, 15 Jun 2022 10:40:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p25-20020a62b819000000b00522a8842acfsm3071217pfe.40.2022.06.15.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:40:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, samyon.furman@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add BCM6813 to bcmbca arch entry
Date:   Wed, 15 Jun 2022 10:40:18 -0700
Message-Id: <20220615174018.1991631-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610001534.14275-4-william.zhang@broadcom.com>
References: <20220610001534.14275-1-william.zhang@broadcom.com> <20220610001534.14275-4-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jun 2022 17:15:34 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM6813 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
