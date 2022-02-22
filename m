Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3966A4BEFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiBVCub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:50:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiBVCua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:50:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66E325C71
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:50:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso1077000pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Isgg2NAdJUzi3J4P4dn0vhqYpm3/s71JaZYff452jlE=;
        b=nQqwkwpq4xKEkx1dkr9CjRaZcoZdasEGPGiG/zXrTSn9MQD1lboHRWXD52vfXZcdTx
         2qyc3BUGpfZ2618aLOsLHSL9dhZgd3y6MkqSi8WNbw7Y59quq032f2BzH3FqXTxZAFXV
         mOJOfOsgLLwDq/VNAxOBGr0BK21cv1eo/ekdTLvZ4ZOTCtGab8T4/aDy13IHBz0d1wiY
         6L8GmtRcPeDw/iBfRHNVyX28hLqWPjItK6SDQmBTm2mBCz0fAA80j3cYZ1zJSmQJyHXm
         1ie0b4c3QXJH5RgWmM9GiSU8TAI5SuA74OxJHX1fyqlv9w8AxFPQgtT/yOtrpi0M1i4U
         Jvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Isgg2NAdJUzi3J4P4dn0vhqYpm3/s71JaZYff452jlE=;
        b=wo4hbfKa3o0Temtfc3Q6zw1kN2/ej2I5YnpNPdBLLl5TjdmCs5eI67rAWchB+mR6e2
         gIHGID2O3syBEd7VdMQ46RoX218K2l2egVmRqzMGJApvErZ9MfeKCqN57U53jjSjlYMH
         ifOCsNEZP1VGRXEo+rDjSkW70eWnnu6T2rC6nzdJT/FfzI2dFuOjuBEsiOyRDI7l2Eba
         EGslBZcBlY9zdwdDBH0eUTrS+H5cfEqUnyUhKmhO2Fj34dvqqFzZeMde9wW/p0a7r+bT
         IqBDARrQAsH8N+wrpDN1fIj1YruHkHQZsEJHEu9zp1/PaoAJsC2U23RMhkcWcqcMJjcW
         rKMg==
X-Gm-Message-State: AOAM5312fL0uqqPrvOYeavXGoB5YeRhspFbn/la26/Qi9x5+twjB5pIS
        A1p2XO6bQ1tBDwC+WbUWUbSYiwt4TR500wA8zpk=
X-Google-Smtp-Source: ABdhPJz/R1rx3Wh3dG8Kya3P2T/VcER1sJi77IgvdLbLw9knbiomuFBKezry9qn5c/Hg2XXl4KBTTqeFHweEUYL/Dks=
X-Received: by 2002:a17:90b:1c8f:b0:1b8:c6dc:ca61 with SMTP id
 oo15-20020a17090b1c8f00b001b8c6dcca61mr1890026pjb.13.1645498205076; Mon, 21
 Feb 2022 18:50:05 -0800 (PST)
MIME-Version: 1.0
Sender: kamuldulzim@gmail.com
Received: by 2002:a05:6a10:128e:0:0:0:0 with HTTP; Mon, 21 Feb 2022 18:50:04
 -0800 (PST)
From:   Mimi Hassan <mimihassan971@gmail.com>
Date:   Mon, 21 Feb 2022 18:50:04 -0800
X-Google-Sender-Auth: o9HszGvBNoVvqWvu1U6La9Ua5Ic
Message-ID: <CAPhCE2cGc-hc_sx2RQU5cN7eSfz1TyrG9XJWYWFOitPu4S1CAA@mail.gmail.com>
Subject: reply me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs Mimi Hassan and i was diagnosed of cancer about 2 years
ago,before i go for a
surgery  i  have to do this,so  If you are interested to use the sum
of US17.3Million)to help Poor, Less-privileged and  ORPHANAGES and
invest  in your country, get back to me for more information on how
you can  contact the company for where the fund is
Warm Regards,
MRS.MIMI HASSAN
