Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D00576A76
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGOXNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiGOXNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:13:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704838BAB6;
        Fri, 15 Jul 2022 16:13:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j1so4181264wrs.4;
        Fri, 15 Jul 2022 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IZ9+e1HnCqiTeYAjFblApCnx6Lp5ZXaovlWuKELwtI4=;
        b=Q4QBOERZCmJKefQrMX2rfpgorYjIn3HRsKlVUddEAWQnpefW7BaDoo8APOt84xbXPx
         AdVjS3NuN5yCo6hZvA7yeEgAC/jVHa7xyOnMUM3VweviiLTdwGcMDHS4tctCDulVeGle
         SmGxtu0qofUwE2UrmD/UGI3b5eKoqDvpS1dSyv7ZOXjOSkGsRiUKeh322+h7UroOd6Co
         wS60BDqI3wV3e3JCeihbrrsXG0dvtyHw3h1GbQ6LFNKKOSU0IMxm4ujGrrha7HG6w4Lg
         OvLdCVWl6vOhywKrgFC2OS03jNuhgFdG0AIqDCC4eP9L33AQEwnfrSuItqciW8QQwhow
         cqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IZ9+e1HnCqiTeYAjFblApCnx6Lp5ZXaovlWuKELwtI4=;
        b=SGQ9MIISM6Zzb2D/epN85WhucztecdhuLPE7iWTS8ZozeE6GsdrOHc8325HF4olILw
         fCUiFJaWaH5upYiepBeprmIZvAd3+RRRizoA66QtX29S42QsA65Fev3kYev8H6cfADdM
         y4mUpLyy/7p+eK6YAuKqvIcuBQKnNKyHZrqmQNmYICNV6hgQsjteUh34ZyGWfWp4tr56
         +5U9P95U3gG9m7IDEKM12JnmcOEdWmO4A2BSDbf+JBTdJKYyRi6xbcVfRpP6ikKV/FQN
         krALe4/+O35jBWSPG+iMVIYwpDYXLE+LqrMKSDKE9M0tSDdi6Sjw+efy8nmEM1Yf8RYi
         yRyg==
X-Gm-Message-State: AJIora88WVZFWkcWp4uHePkYZBX3Yfo+yJPM5Sv1bEnWqc4j7pp37bBk
        90VYmjCK6VhRK+aKY0P08j4=
X-Google-Smtp-Source: AGRyM1sOoZxODX4Y6Y9MgmGI2BIvCNz/7jUbHSG79DLbNq84EIF/qBaY9icEx/1IGJpgy9l8T5ITuQ==
X-Received: by 2002:a5d:6d89:0:b0:21d:a6db:df63 with SMTP id l9-20020a5d6d89000000b0021da6dbdf63mr14712106wrs.491.1657926784903;
        Fri, 15 Jul 2022 16:13:04 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003a2f96935c0sm14324140wmq.9.2022.07.15.16.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:13:04 -0700 (PDT)
Date:   Sat, 16 Jul 2022 00:13:02 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220715 due to "comparison will always
 evaluate as 'true'"
Message-ID: <YtH0fux43jxgnCCC@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, gcc-12 builds of csky, s390 and x86_64
have failed to build next-20220715 with the error:

drivers/nvme/common/auth.c: In function 'nvme_auth_dhgroup_name':
drivers/nvme/common/auth.c:59:13: error: the comparison will always evaluate as 'true' for the address of 'name' will never be NULL [-Werror=address]
   59 |             !dhgroup_map[dhgroup_id].name ||
      |             ^
drivers/nvme/common/auth.c:39:20: note: 'name' declared here
   39 |         const char name[16];
      |                    ^~~~
drivers/nvme/common/auth.c: In function 'nvme_auth_dhgroup_kpp':
drivers/nvme/common/auth.c:69:13: error: the comparison will always evaluate as 'true' for the address of 'kpp' will never be NULL [-Werror=address]
   69 |             !dhgroup_map[dhgroup_id].kpp ||
      |             ^
drivers/nvme/common/auth.c:40:20: note: 'kpp' declared here
   40 |         const char kpp[16];
      |                    ^~~
drivers/nvme/common/auth.c: In function 'nvme_auth_dhgroup_id':
drivers/nvme/common/auth.c:81:21: error: the comparison will always evaluate as 'true' for the address of 'name' will never be NULL [-Werror=address]
   81 |                 if (!dhgroup_map[i].name ||
      |                     ^
drivers/nvme/common/auth.c:39:20: note: 'name' declared here
   39 |         const char name[16];
      |                    ^~~~
drivers/nvme/common/auth.c: In function 'nvme_auth_hmac_name':
drivers/nvme/common/auth.c:117:13: error: the comparison will always evaluate as 'true' for the address of 'hmac' will never be NULL [-Werror=address]
  117 |             !hash_map[hmac_id].hmac ||
      |             ^
drivers/nvme/common/auth.c:94:20: note: 'hmac' declared here
   94 |         const char hmac[15];
      |                    ^~~~
drivers/nvme/common/auth.c: In function 'nvme_auth_digest_name':
drivers/nvme/common/auth.c:127:13: error: the comparison will always evaluate as 'true' for the address of 'digest' will never be NULL [-Werror=address]
  127 |             !hash_map[hmac_id].digest ||
      |             ^
drivers/nvme/common/auth.c:95:20: note: 'digest' declared here
   95 |         const char digest[8];
      |                    ^~~~~~
drivers/nvme/common/auth.c: In function 'nvme_auth_hmac_id':
drivers/nvme/common/auth.c:139:21: error: the comparison will always evaluate as 'true' for the address of 'hmac' will never be NULL [-Werror=address]
  139 |                 if (!hash_map[i].hmac || !strlen(hash_map[i].hmac))
      |                     ^
drivers/nvme/common/auth.c:94:20: note: 'hmac' declared here
   94 |         const char hmac[15];
      |                    ^~~~
drivers/nvme/common/auth.c: In function 'nvme_auth_hmac_hash_len':
drivers/nvme/common/auth.c:152:13: error: the comparison will always evaluate as 'true' for the address of 'hmac' will never be NULL [-Werror=address]
  152 |             !hash_map[hmac_id].hmac ||
      |             ^
drivers/nvme/common/auth.c:94:20: note: 'hmac' declared here
   94 |         const char hmac[15];
      |                    ^~~~


--
Regards
Sudip
