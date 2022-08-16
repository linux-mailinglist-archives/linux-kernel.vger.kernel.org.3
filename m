Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08018595A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiHPLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiHPLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:33:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BD21BB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:55:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso361225pjl.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc;
        bh=zHDUV1ArSvmmbVuVL5plmHvTewEjp3mhOS9xvo6KGJ0=;
        b=B9s59uwh02/hoPr0mMZGQo5SzK3tyFdn1Zj4KGx5AQh5wvQ4T1xJtPVbPlXvjZpex5
         zrem/4itWV8CsJhbz243aD+rhMCH8xjWvgwneOv66dOew2ljH6LBsU2ZX9wxTnSPEUq4
         9QHb+zhcDPh1YqBGudp5/vJuxQdRPycPL7LCB3iVhwss8wjx/H3xpx7iybH3r3jVkuq2
         eBb2qAUZ+mxhbGfMWFpy5pKtgtIoEnBCtOYq0mKwbTZE0d0wPmsSkYJaWBqxFEFq9hAq
         npCziNfawJD+FIFAV6DXM7W9CnF+Sh96gjvaE0smf5ExZalNLy4LmEFA6etSe53rSlPe
         x7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc;
        bh=zHDUV1ArSvmmbVuVL5plmHvTewEjp3mhOS9xvo6KGJ0=;
        b=Hl7x3XfTfx+2k4Cg3952i5xP4F2S8eadW75GVfdHtSWyAitN1w59cxJGxJNKvB3P9w
         H8lMHEdmwzT/czQkDQ3TluxEFLbpTyuT5iuk66jaTvIH6R/m1WnitrwEY3sB7f9DBnRq
         SCjnxwxtGdDPhESCqTJyq/oM/jiiOr9Z2t3Yp3TZ6eFqzysGETkqMnrae/xpusTIdOTg
         PimaVABpDsBQcc8z9fEhsZDdq6C/Ffp5cbDPkus5N0d1DkrBfydo+06Sj0dlUBs3xOs4
         CjrWFhoEyH3Fqm2AzUDmnf1elW+J+cSrUmSNgMxxBxb8rxKEH17KDWDSSHIg7itG5/Ef
         q83g==
X-Gm-Message-State: ACgBeo2C7rsBvNd/TYlVnBVeFX6yu959hdQiEqXstHGEOsQS+DRQcjxS
        UFt40EtpdsPLEuRoy54i+ZCS32IC5DLVow==
X-Google-Smtp-Source: AA6agR5/6rIfJw4mjBqGkD7eRhHrpSTf+4kpQ2h6LwKIUwSRmkTDZyrKvhbgt4YWCXVk7h2H8ENqCA==
X-Received: by 2002:a17:902:b948:b0:172:800a:cda8 with SMTP id h8-20020a170902b94800b00172800acda8mr1987223pls.90.1660647353638;
        Tue, 16 Aug 2022 03:55:53 -0700 (PDT)
Received: from smtpclient.apple ([211.221.84.79])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902a51700b0016bf4428586sm8694250plq.208.2022.08.16.03.55.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:55:53 -0700 (PDT)
From:   Chang-Ho Cho <changho.cho11@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3 3/4] kernel/smp: add more data to CSD lock debugging
Message-Id: <AEF6AAF1-0529-4661-AA6D-F9E41CE9DA44@gmail.com>
Date:   Tue, 16 Aug 2022 19:53:49 +0900
Cc:     jgross@suse.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
        peterz@infradead.org
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=20

Google search brought me into this thread.  May I have update on the =
progress of this issue? Has anyone find root cause, solution or =
workaround?
How can I get more about the problem?
Windows 2008 R2 VM experiencing hang on QEMU-kvm with IPI handling =
issue.=20

Regards,
Changho=
