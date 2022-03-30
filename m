Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278464ECF16
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351366AbiC3Vu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbiC3Vux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:50:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2791A3EB8D;
        Wed, 30 Mar 2022 14:49:08 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i7so9333432oie.7;
        Wed, 30 Mar 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=b0i0cluH/A4ssoKeXKqLMuzYYjVRshLdbvm0r5GSUI8=;
        b=jHILTx22Yafv+bS1q6k9rCJzsp5MTUG7AYTq0FCpQbD9cS1T63FfImnVdVLI6S00Jg
         bNRdOYt0SSnBvqjx0FBXpeHos8zXj6+4VfIG3a80MHJInuhfpUe1ehmKOlVcwvDbypwr
         mRhMLRZwpMJzAT8C95oUgpj5PjYI33dzB3mkQOYyzxbUvzlpBCy8e4N442ES40mQvxRm
         4Z6aE6aL2HogZ1MyVJPanoowLllmBjZ1KLYs83P1HBJn4LTMpk40kuR4/49/FyhrRquB
         /Q7uYQwtH8XtW2LMNTTIhieHF9DfAJVkDEbkkoAt8hDO0K8Ww537sQcsGPgYeKn6AOsU
         AShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=b0i0cluH/A4ssoKeXKqLMuzYYjVRshLdbvm0r5GSUI8=;
        b=oyYiwD8af+8508UO+AEJRN+uWTLxsNMqWa2kOZ7KkWBFN/vffR+7p6tUksIQMoiOFJ
         XhGChtu1UvPHKsS2mNJfFiCzu7g/y7QzXNrdet53F1bIQ5i+j+eoatOjzMhFDU5u7nPJ
         VBT9YjiRml5u3xrfaqZ2fjMCrzLdLXybLgFBdhB3c+tBG3ZIDyR2+m5/Dm5aC7sScV7L
         CTTcYNeGcYKa//PWQ/T8lSB+iU3RZcpxnpr03ToBcpUKILm73OltWjR7ypTZakmsJE17
         yYaA1NpTdF7SS+2CyOzyCTWERDXFprj26hPz5W8i5g8maQbjIK/KTRKmpOTZuw6aAeG3
         55qg==
X-Gm-Message-State: AOAM532O5Mq7dPq7r+X1adCqJMvnP2JLHRUicX6twj6pAFiD7Gns09ID
        D/RzsDL8PLkwH56XmCZcKayL5WfxmBMBOA==
X-Google-Smtp-Source: ABdhPJy3jQXpJ9gCB6/IK2LSmIYfR24mlHix7Sr0O1n/2dpJvWTwE7PqijX45a4zdov45Ef2TOxxdw==
X-Received: by 2002:a05:6808:1513:b0:2ec:f606:2c9c with SMTP id u19-20020a056808151300b002ecf6062c9cmr1161024oiw.256.1648676947438;
        Wed, 30 Mar 2022 14:49:07 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id bg39-20020a056820082700b00324c8eba341sm9680574oob.18.2022.03.30.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:49:06 -0700 (PDT)
Date:   Wed, 30 Mar 2022 18:49:02 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        dan.carpenter@oracle.com, julia.lawall@inria.fr
Subject: [PATCH v3 0/2] Add a section for static analysis tools
Message-ID: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the third patch version in the direction of complementing the
testing guide documentation page with information about static analysis
tools.

Thank you for your suggestions and comments so far.
These docs wouldn't get so helpful without them.

Change log v2 -> v3:
- Changed the paragraph about Sparse to make it sound better (hopefully)
- Minor adjusts to make the considerations about Coccinelle sound better
  and be precise

Change log v1 -> v2:
- New patch adding considerations on when to use each tool
- Brought generic tool characteristics to the intro paragraph
- Made explicit that these tools run at compile time
- Added a note of caution about false positives
- Updated Coccinelle info to make it sound better and be more skimmable


Marcelo Schmitt (2):
  Documentation: dev-tools: Add a section for static analysis tools
  Documentation: dev-tools: Enhance static analysis section with
    discussion

 Documentation/dev-tools/testing-overview.rst | 63 ++++++++++++++++++++
 1 file changed, 63 insertions(+)

-- 
2.35.1

