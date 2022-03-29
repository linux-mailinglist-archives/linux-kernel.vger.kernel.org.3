Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1264EB6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiC2XXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiC2XXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:23:39 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C54184B48;
        Tue, 29 Mar 2022 16:21:55 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-dee0378ce7so10047342fac.4;
        Tue, 29 Mar 2022 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Upj0YaAjIHg7LwZ8gYjFdHojisRvoPEaU9Jk8lm3iwE=;
        b=GhRQuIo5ZO/bfsxkkU42vkWb+WpXXnvB58zDU+aQa52kujXmaLh+dI9T9txmY6lwsF
         0RiuRQGcpIWmBrqvNe8+BTEwtdA8AEcm+q+Zk+hGoqmz2MlN2lvrmROxVYK3AvZEpUe+
         alrwAtT/dbEjJ95WnJRnxrCunkATzsQb7bbR207luGyQsQYJW3qk2hykGIO+/F/iLd68
         tdAU0cj1D3bUz+49uQY28XYw1jmXmPClT9dN0hjd72Gh1TOMbtONGFtPnuYqd1I9hPzM
         zFx0SUP6xui9taWYPHKd+wchqpxGEJ+oqSR6Y/OcWLFdha2wBxKfzqA9XE0wTm2L9o92
         /2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Upj0YaAjIHg7LwZ8gYjFdHojisRvoPEaU9Jk8lm3iwE=;
        b=F9poJy3M7TN6THBlrt1M1KE+LB5jzAJQeEgXMTpQwppPXc3HTX2kMnkTvIFQdx7HqI
         4kGfY/Tb1pGxBVufLchuAcxc2aqRvAZgGdRfPfEfCGb+IGe0pDLyRraHxbSLpyqjKwQA
         cV7VGHTJE3DsMlwIpm+SJiAj5++bnsuzuW9niJ523gaZG5fHokjPHCeZivSN4lYqKfrw
         csllA1gPr5x8ib4piDBF3XSQnaIe2NTeb1xHcvdyn2lgMU6wlaj6m4GyS+JM/txksyT5
         XrzQjgyyAnRblg4cX9/9dNJbnZzJa67JaUb89jBlf+5Usxf0f726Mp7+tiFKyrZuhlOv
         DLtg==
X-Gm-Message-State: AOAM530kRqOlaysw/vE/LelGWV3ZHQugvMj/toG6tisfagipb3gr9+Ce
        uNaRAh6Sj9NJ+lhDW6WPMKQ=
X-Google-Smtp-Source: ABdhPJwt2GsmCq6MTV2PLGWD0zAbfAjRcS3J+9Y8MBRZ76lEqH/agkWdziL8qQpkkZl8OoqBGpw73g==
X-Received: by 2002:a05:6871:811:b0:dd:b8ea:6bb1 with SMTP id q17-20020a056871081100b000ddb8ea6bb1mr869561oap.43.1648596114721;
        Tue, 29 Mar 2022 16:21:54 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id a30-20020a4ad1de000000b00320fccd02cfsm9364788oos.5.2022.03.29.16.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:21:54 -0700 (PDT)
Date:   Tue, 29 Mar 2022 20:21:48 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        dan.carpenter@oracle.com, julia.lawall@inria.fr
Subject: [PATCH v2 0/2] Add a section for static analysis tools
Message-ID: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
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

Hi,

Thanks to everybody who commented on v1 for your kind and much helpful feedback.

I tried to add suggestions and ideas while keeping the text concise.
Also, I took Dan and Julia's comments and included them into the
documentation (patch 2) because I think they were very helpful in
comparing the tools.
I didn't feel comfortable adding something comparing Sparse and
Coccinelle directly as I'm not an expert with any of these tools either.
Anyhow, that can be something to do in the future.

Thanks,
Marcelo

Marcelo Schmitt (2):
  Documentation: dev-tools: Add a section for static analysis tools
  Documentation: dev-tools: Enhance static analysis section with
    discussion

 Documentation/dev-tools/testing-overview.rst | 64 ++++++++++++++++++++
 1 file changed, 64 insertions(+)

-- 
2.35.1

