Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6B4EDEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbiCaQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiCaQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:24:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354E80216
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:22:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so447143wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=SNHHRe2ZzSNGPseirROJTlFiRpkfoRkugNhNQv1nRKk=;
        b=m3VDo8KCl8P+V4rf3xVWwaVhbr+cX5UmB4yC7/mdt8W2DiSVPWMD0Mx5roh0RI3Q1C
         Qe01vvmYQJT09wuww8YchMsU0t/SF6kJj69xtox/xrc2e4S0FvBQipOE6trErxrXGDjJ
         t2UTMwXOObHwFrL4kZanDWgA24YCA/lLkUFECSDoqEv3PzBsDSzlcBLaQK5V+UyKD7/A
         u0i0FEZZ3Z97m3Pxsup9JEUEH+GoOTezm5QQq6HbRqkTkUyEpWdOne7Uj0sv669YrpDB
         G8/jArjUxecNWvHeV+RIjWcqmTuyQ8cPQetRr9WRC2IwIhPR6F754cmhljuRYGBe7M3s
         aMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=SNHHRe2ZzSNGPseirROJTlFiRpkfoRkugNhNQv1nRKk=;
        b=LggG4tyZBfLt954quBVds+7GvpOFOp4z4Z1gkgsIiJsUkbIisrK89bQFHVDeL98bCb
         rrspb8xVepBfqGdXS8dhJptGWxBSQH3PsiVw/3mUbCg98zp00CIC8LvxL9s2lzZIDgZI
         HYtZ6nH5oke0Nehi1IW7E12jNHgy/9RM4L4CLzhytR9Uq8Yy2BUrvkGE29oyDMzG1d1C
         XxHxL5kd2c0+p9ugY8hqb7gqLnGEnKi27wOumO83Rs2dEP8Z8/xEjfMCBz0jP7Nnt0sw
         x4tUwBqBQV3d38qQ9gHFw0qGHbpfzXBEY4aPPyCQLaikk29rBZHcWL+yLy4G/TkigDDe
         3z2g==
X-Gm-Message-State: AOAM532PWFDwDnIfnkJPZDvzvXRqzZEzlykdpoqfSQydV1HbcXVnvI9Q
        /A08fQuKKO1KP9J/a3Ue1dlnShni7pbCMg==
X-Google-Smtp-Source: ABdhPJxapObZDmfaVs9GX0oYTb+BXJWWgI4ZkGLoFP88o8ev3BQBHyqCnzKwFo2/AXVzvovKCW8stQ==
X-Received: by 2002:a5d:650b:0:b0:203:f4f9:85c4 with SMTP id x11-20020a5d650b000000b00203f4f985c4mr4689958wru.345.1648743738390;
        Thu, 31 Mar 2022 09:22:18 -0700 (PDT)
Received: from DESKTOP-R5VBAL5 ([39.53.224.185])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm24785119wri.111.2022.03.31.09.22.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 31 Mar 2022 09:22:18 -0700 (PDT)
Message-ID: <6245d53a.1c69fb81.368db.3965@mx.google.com>
Date:   Thu, 31 Mar 2022 09:22:18 -0700 (PDT)
X-Google-Original-Date: 31 Mar 2022 12:22:17 -0400
MIME-Version: 1.0
From:   nickolasdreamlandestimation@gmail.com
To:     linux-kernel@vger.kernel.org
Subject: Estimating Services
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
Kind Regards=0D=0ANickolas Casas=0D=0ADreamland Estimation, LLC

