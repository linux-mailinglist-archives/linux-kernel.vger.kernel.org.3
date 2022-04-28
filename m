Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284295132EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbiD1L6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiD1L6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:58:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0B5887A6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:55:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x17so8141733lfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2Yz3tOWHL+ez8i8Sa2barju/WRxAdVvNy5VEOJkJajY=;
        b=gxIilcxAmzFhXZuf3sqFfqGSlb+pC+SZeBrFa9J3KQ4qzpreZHMOU5qzgUbCa/3Ds/
         95hfRTDAbS/qQqUD3Urd8ew5OZ/q7EGIXcyF1TEkvFodXvqyLL9Lg1f6E9wZF6eXS4fe
         kMu5N4Pnc/nLglhf1Fij5nwbzBI5jGAQSVi2zblzAIGsYomGO57yATkNEdq6YLWzODQf
         uWGOPEUBO048HDXACmSGOxZho2P+FyRQ10P12PSTBjYN4ChqU66+VyfWfANKyQXMsFBt
         hkPlSCPF5e5zu+BFo8+ctrBZ69vLf6s8ZNv2iCYQEBiTLQDpd53sp5R9+h3GYQpc5HXQ
         c+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2Yz3tOWHL+ez8i8Sa2barju/WRxAdVvNy5VEOJkJajY=;
        b=gwgPNfXBlkuYdcNQr8HE5N4Mrs0yNaqhCIuAsOjCqgFcpjc9/aCx6t6G87SK/cOTiR
         9NF7G5dB06gfMYD60AuXQ2H99YGJ+n7et5MBfS/XAI4iKo6DH7p5/FbCvNYEU75Yiy2H
         eFH2WUaSuienQZd/VyRL+TmrEHGi7iJWKPr61m6/mAhPKxnrzOEK4a0Jat22vlfMQ5Q7
         2Lu8gXYkkRE27KDtgAR6bocsPUVoxC3YgMuim7Tdo5lL1rIcl9OeY0dsZewtxE0y7i0W
         CmFLyE8zwmrEYyOffOFU9fDrwj9fmlrT6q3Cei11zBfS9nN7SM/RkSvfvyGXdk4rlxP+
         5jMQ==
X-Gm-Message-State: AOAM532epWka+yHgG4cMEMQJ4/i+Gk+xVwa2dw412l93u93Y5W0M2Bg/
        h51oc70E4cDRpgInRfZW59n7d8kdAXLB41pedxg=
X-Google-Smtp-Source: ABdhPJy961kAxggOIO+ZTh0LS7gqVCMdSfuYt0nOHUFCD9G1gkfjPCwdA+9BQvSSyCBoxkVt4Y0lqvHnZqSroVZ4MV0=
X-Received: by 2002:a19:8c1a:0:b0:472:315:48db with SMTP id
 o26-20020a198c1a000000b00472031548dbmr15447607lfd.235.1651146917650; Thu, 28
 Apr 2022 04:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:181:b0:1be:92ad:cad9 with HTTP; Thu, 28 Apr 2022
 04:55:17 -0700 (PDT)
Reply-To: ahmdkalifaz@gmail.com
From:   Ahmed kalifa <hwbkbq@gmail.com>
Date:   Thu, 28 Apr 2022 04:55:17 -0700
Message-ID: <CAH_uxJEqj4bvzrG=sHpqc3DPU7KKo_QsH=EscqSmFsqambvDnw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hwbkbq[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Attention Please,

My name is Mr.Ahmed Kalifa, Branch Manager Dubai Islamic Bank United
Arab Emirate
Are you the real owner of this email address? I have important information
to the owner of this email address.
Due to the sensitivity of the information, I want to be sure I am
communicating with the rightful owner of this email
address to avoid making a mistake.
write to me so that i can give you the important information for your own good.
Congratulations if you are the real owner of this email address.
I am waiting for your speedy response
Thank you for your understanding
warm regards from
Mr.Ahmed kalifa
