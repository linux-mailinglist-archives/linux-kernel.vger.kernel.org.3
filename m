Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E618A561FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiF3PxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiF3PxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:53:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBF39815
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:53:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b26so15567224wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=PC0C+IYmZqgzCw2evluP2hpSsCJzEX6s3IMX68ULD3E=;
        b=hsYtETkpmn72+rQZxpOB6jLy0jfezV9VtirXL5cSK6W6ssisXLm1oiZykSnLnbK8Ww
         WhRCPjuXquShmieXSJHnDwurezQPJrYSyONiCMrTQj+QexdnbyQOelbtzJs1ZWEBrTSZ
         ZgGUGNZGmC1RPfcGPiKfuLgjdCRoSe7v3GjBHqIl7VV8PgFnHdpxKp80mHkgwA1Ov7HG
         4BNWUvqBU+xszyXOG9Pq8uDYx9BiKx5Wuh39VcfSCzT2vPiXrVlc079J3O0NjsXg7hME
         waCCD4ylXfAWH8uPXFsZo3+bceBFWX4dgDTcwdbJiz1Pq1LKLActhkfc8dYL++QwQpKs
         Fdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=PC0C+IYmZqgzCw2evluP2hpSsCJzEX6s3IMX68ULD3E=;
        b=qxTrwy5fSXbD0zbWqeUNuJjnQgKRvurn6BW9h2IEaEggK0E6ZxuaBW+zD0+yi2gd9V
         jTT7E/aTP8vuAq8uf4e6255YmoOi87NiNuBRxlmf/g/vqQj5ChNs6Vl/59XW0k285lpF
         AyyLTaiIKUOz86ZfIl2XytgCFLKeOd7LUObXrbM/SaFEgIWLhpAakQ3xZJ8EVtuWay58
         U+UGQyb+81sU5cT8OGmv+3bSBiUfBfcjtCad7v9urpE5BBFxqXJfbrEE7UDQm6Pdfap6
         r90AQ2sIymoxmlTuYF+rs7rTd+KeQhx9PMsRImRmLQA6vNh7W15qdEjuc3Ol8cSE8yE2
         QA7Q==
X-Gm-Message-State: AJIora94QNNMr4RJFCxMjUV4/Fw3qJeCdAYgpKPRfTc4SkfceykpiLCG
        A+IZDQXbtaX3KhO8GWOVoGceNLoVuG0=
X-Google-Smtp-Source: AGRyM1uGdPvAJx2lq0i+7HV7dXLGT8EoB1nHi4JtS7WGc3t74tLpcMkX1DS5ZFGvmZlRwznZHLCnGw==
X-Received: by 2002:adf:f84a:0:b0:21b:88b8:183 with SMTP id d10-20020adff84a000000b0021b88b80183mr8828050wrq.265.1656604380058;
        Thu, 30 Jun 2022 08:53:00 -0700 (PDT)
Received: from DESKTOP-L1U6HLH ([39.53.244.205])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b003a02f957245sm3076054wmb.26.2022.06.30.08.52.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Jun 2022 08:52:59 -0700 (PDT)
Message-ID: <62bdc6db.1c69fb81.c23ab.6c3c@mx.google.com>
Date:   Thu, 30 Jun 2022 08:52:59 -0700 (PDT)
X-Google-Original-Date: 30 Jun 2022 11:53:00 -0400
MIME-Version: 1.0
From:   elda.dreamlandestimation@gmail.com
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

=0D=0AHi,=0D=0A=0D=0AWe provide estimation & quantities takeoff s=
ervices. We are providing 98-100 accuracy in our estimates and ta=
ke-offs. Please tell us if you need any estimating services regar=
ding your projects.=0D=0A=0D=0ASend over the plans and mention th=
e exact scope of work and shortly we will get back with a proposa=
l on which our charges and turnaround time will be mentioned=0D=0A=
=0D=0AYou may ask for sample estimates and take-offs. Thanks.=0D=0A=
=0D=0AKind Regards=0D=0AElda Pierre=0D=0ADreamland Estimation, LL=
C

