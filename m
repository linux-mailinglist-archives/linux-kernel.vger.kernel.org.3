Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41BF56BD64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiGHPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiGHPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:16:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E4061D42
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:16:44 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y2so19953885ior.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=vrQS/LlIulyYlkXBBH9HRrD0LEcs8mMtInf14LMYorQ=;
        b=BqAQdK1cp7aPF6dkOTpNvCs6Z0niL9fhF6JBqciHT60KkM05Pg/GhLK5Md+XdOV13G
         W80xuIWpw7w7NLH6zpKyNjigmo3+3mVGzQsRaVxSye9+SUbMOhXxC4iXJyvP8Qvr8VHp
         oB72VYK8Y0dsKTvibn/3cU66a4DuGOO5CoCiiM26t6wSUnTEAGlyttHRMI7VTV/CaY2Y
         8VygR7N7SVv1rFXebFNJ1AW4JOjPTcjN2c/Tzp2jfZnhvdbOBAZLhsF933WfdopP0EF7
         W4sU0kpzRr/4A3CVCfpCakuJs7CjXnrCaMJCqHY4MLJSRctLRlWC/ciai7fz+k6KULih
         POFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=vrQS/LlIulyYlkXBBH9HRrD0LEcs8mMtInf14LMYorQ=;
        b=sld9X3vLZD+maxvZ9GEbi9XYEuSTzO/5eibz5DoW3GVF9ZRNYCvv7u8DJiguslCaos
         KMuSD/iwLhoVqnOBmmvNMAABiHkOOf2UbDqTjo9J53Xemzq05olNuXEdw0XvemvMU0zm
         jjgmnAHKSDmJ6TSA+C4HFzjw/T6dxyoNwxmr6fepOdpt6zntxpQsyHzoHzj/KJ0PZdYa
         0QhmU8eZ0Zh3UF/sz+Dpp8pDUbmRmHTiSqvRbEl6LVXeAY9ISqeD2FF0ECEmWMZhrT1w
         esHV95Y3hFVCI2QsaqCaeg7OLgbFFKwcX0Z0mcXi3zkAhx26wSKz/hVCQkMo7ZlKB1/v
         iYCw==
X-Gm-Message-State: AJIora8UMvxLoartuKc9EyjWP2F4mcgUkpdHYzn3soFnwiHcCXgjyBJ6
        YlQ/5VdgtaeUgJkBwpH0jBOSTiZbnXXG7eLOZJI=
X-Google-Smtp-Source: AGRyM1tx1vkQPSaQb3uyxDHVuG5BvI3FVaPagnLY5aTIxfaYvaOG/uM7XwrA/bIYUW+l9G39KpOQQ3bUswq5Wu6Twaw=
X-Received: by 2002:a02:6645:0:b0:33e:f553:3a74 with SMTP id
 l5-20020a026645000000b0033ef5533a74mr2460275jaf.0.1657293404355; Fri, 08 Jul
 2022 08:16:44 -0700 (PDT)
MIME-Version: 1.0
Sender: tinaevan101@gmail.com
Received: by 2002:a05:6e02:1605:0:0:0:0 with HTTP; Fri, 8 Jul 2022 08:16:44
 -0700 (PDT)
From:   Mira Thompson <mirathompson1010@gmail.com>
Date:   Fri, 8 Jul 2022 15:16:44 +0000
X-Google-Sender-Auth: gbMoRN-hQs574xXxRdw6cCCFLF8
Message-ID: <CALL7qtxcugKR_ObbMsuT-OOS-tn7hD64_=ng_H-YpVZfjn4Aug@mail.gmail.com>
Subject: Please reply to me as soon as possible okay.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello sir.
Please I sent you a message and I have been waiting for your reply and
I could not see any. I want to know if you get any of my message to
you, kindly reply to me to notify me okay.
