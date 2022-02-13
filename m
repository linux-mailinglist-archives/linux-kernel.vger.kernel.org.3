Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B34B38C7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 01:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiBMA2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 19:28:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBMA2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 19:28:43 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AAE5FF3E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 16:28:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id h8so3637422ejy.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=nWMPQ7E9x3/OYrQfauw3ijYIqaFzwezrTXKGoEnLtSo=;
        b=imdOJ9Nf59c8NH9kFGBmSi+iuoUIuVhZtnmK3OuqJtCTIUBri+/WZB3fTbD2ILwJMD
         JMsESpZjloig6unQFkfiOZ0s7+XyWb5P+/5te9q1ITYOk/fxdPM9f53cDiMNheiejBCU
         HWuINi6SKrSR3pT/c5LS5drLMGyIrShvIG3XOWeiFALIjCZmlndnl8ehiUGWqifthucV
         tzExFMCMkc4QaNDkK9VBS5Mr+e8+NXR+9rvz1gLv5VZ//swwPBqlwVBoxmjeunyz9fFO
         D8HrNlPn5pnK6HRrGDoLziENY6OwJYEPS/AB/vkzKZeUOuJiovldqiZFD1BT5ES+RWMq
         LP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=nWMPQ7E9x3/OYrQfauw3ijYIqaFzwezrTXKGoEnLtSo=;
        b=mq64rXFKsjgphcfL71E8cFY79zD/f/Fa+aeJLfzddHEOBbxkOLk/Cahw+/14Xi1ASr
         45RQfeYEoyt0r2u7FMEM5U+sx82iMs9MS98wi3Y/yzf0K03F8yudz+AJOhCuDnXjBaab
         JW2rZ6nzE5RxBPolEznfPYY3yySV+N9CIDsJy601047yjzUK5VKDY7BkK6un9oIXIgGh
         rmw6emewVv3PI4WTEU6IeUL9JQR8/+fv+LidrVmMsPNxEs44P+KGc4LONvcKP/Z/XH+S
         ICfXU71uY8mDMMp5To18a33qErVMUitMkRlyQuh/b3RQ3EvhYyBhet9KJi7CTrMn6Bd+
         Ez7A==
X-Gm-Message-State: AOAM531Mjwfom+Jl/jVrGVaP65+YH2nNq9ZUE5Npemam6sjVcXfW6Dq0
        nWLT7Zx1j+sQGu5rG1X8IRgQBcMhYf8zmgaj
X-Google-Smtp-Source: ABdhPJxl9wOQBb3ulk2O9GnHSBYTUC/vKSrrseVenyGbzi1pMJh1h4YlZjfenQFPUGCj0arbzrH5yA==
X-Received: by 2002:a17:907:29c3:: with SMTP id ev3mr2256694ejc.694.1644712116635;
        Sat, 12 Feb 2022 16:28:36 -0800 (PST)
Received: from [172.20.10.2] ([105.112.24.235])
        by smtp.gmail.com with ESMTPSA id m5sm2983187ejl.198.2022.02.12.16.28.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 12 Feb 2022 16:28:36 -0800 (PST)
Message-ID: <620850b4.1c69fb81.8c490.f425@mx.google.com>
From:   Justin Clinton <me40404023@gmail.com>
X-Google-Original-From: "Justin Clinton"<awahi4good@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: I amFunding
To:     Recipients <awahi4good@gmail.com>
Date:   Sun, 13 Feb 2022 01:28:29 +0100
Reply-To: justin.cliton101@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am a private investor ready to fund any legitimate Business/Project such
as Real Estate, Personal Business, Agriculture & more at the rate of 2.5%
interest Loan. If interested, tell me how much you need so that I can send
you full details on how it works.
Thanks
