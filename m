Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312B4562054
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiF3Qdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiF3Qdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:33:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A23B021
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:33:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so3633401wrc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=21qz1Z80+Dw1e1d/lyl4lJ/UQsiXbri/GS0RbMTGIhk=;
        b=OBvjMwkv+EWD4ZUi9gakMZZl/REVhZIvE+rC75lY06oQ85EGLGmt9UstcKhPoDjX+U
         Sqtqfbcj8UZZDHuC4s1nkDq7QF58Sey07DTlAHzDmE4nW2LF/qcFZ8uQBV6YmzM+klyi
         2k+uDvWmtSXS2Gu2O14J0TdSoF5fFDJZAti7Q877+ICcNN3Cp9sfV6nGBrm5ASAB04Zp
         VTbLMtPCTWPr8nYnqiLSSSRyA+RyTlYMzU2Abh5U0TReevFWNaNH18vlMFT054IrRtYX
         N3LaHWHo74OEDIcil3favZjIjWHkVOH7Ox8kyLBjcGjTWabqnBfiWWFf/DEFQ9IVy4eP
         PVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=21qz1Z80+Dw1e1d/lyl4lJ/UQsiXbri/GS0RbMTGIhk=;
        b=j+eG+YUNd4t1mTJbAv6qqm+Rdikp7LV51sx9ZQjL599qQMXgBrBscn7/EII5bVxCkE
         IqN92wb7uy2hLcLn0uKgChNLgA7zVekfHiiJmO5dvR29eXb8hHBC8LMBWuKinsGATQpR
         eMvKYm3MBGPC271Lyy1robOdfYFScJTmIBspU/Fc/MqZxxjq3OoRAtGHQP/1HAEveSYE
         Mpxt74AJ3k9GJTlXP69TAZdDcadU9gpTTkqbZ7WM3EV6MFp54R8v45k+B0TqBXgzdK7h
         1AoCoJZ8DiVW6BYxSezerz6kzc/v4HZenlotqRANyWjz/uIfd0SMowJ3CL+GyTaBpyCb
         j6/w==
X-Gm-Message-State: AJIora+3/0E7p63gUD/6NrDKlDnJaaDJ5hzC5e5xFd0TSnQ2b1xjOXu3
        WRq+/4dubhoEQW3dnigdMa0ClkFDjZycxe+J
X-Google-Smtp-Source: AGRyM1ubuqwvlQgBy0X3toPRrOfhhIs9lK/jFjc1RB5sPYeFKdPsNjDy9ToZYyx88r4F8cX0X/cHOA==
X-Received: by 2002:a5d:6daf:0:b0:21b:994a:a6d1 with SMTP id u15-20020a5d6daf000000b0021b994aa6d1mr9481072wrs.75.1656606828138;
        Thu, 30 Jun 2022 09:33:48 -0700 (PDT)
Received: from DESKTOP-DLIJ48C ([39.53.244.205])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c269200b003a03a8475bfsm3027949wmt.16.2022.06.30.09.33.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Jun 2022 09:33:47 -0700 (PDT)
Message-ID: <62bdd06b.1c69fb81.b8dc8.6d45@mx.google.com>
Date:   Thu, 30 Jun 2022 09:33:47 -0700 (PDT)
X-Google-Original-Date: 30 Jun 2022 12:33:49 -0400
MIME-Version: 1.0
From:   rosario.crosslandestimation@gmail.com
To:     linux-kernel@vger.kernel.org
Subject: Bid Estimate
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0ARosario Woodcock=0D=0ACrossland Estimating, INC=
=20

