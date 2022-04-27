Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30E511478
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiD0Jp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiD0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:45:48 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449137EDD8;
        Wed, 27 Apr 2022 02:42:10 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q13so682354qvk.3;
        Wed, 27 Apr 2022 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=RzBeV6csf1kcl55z0iWFo7Gu9iToJRtYjtwbycbVvuE=;
        b=PMnsgovxt3Gt5Z5kJurqPvuh6FGTa6yZSRda57oDBhWAWSMkOgfrISt1XfVU2jXC/Y
         1LmfGoUxYXlEMKMSDeJhIAIHt4g3k3URQKamZ40OY6iMjrfzaRuN4P8I1UGHs4+W1Qwm
         Wdn8bAKrBpTUQKOgBUmc4F+Q8tQRIcJ4nbuHQz6grUymmgYeEBuxJNgs5hz4p7epmsE8
         WlMThcCMxgWEF1JeITDfHjVOYbITyObNQ7ZaA9jnDXX2AZV4Q0PvL37GKddCAiXV7o30
         s2+BcxsaRTx2f1YH9+ul5nrpfWrr3E8nVrbEpZsQd1yGXANSAOCPBtQlHXrA8/QLrj0M
         ZJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=RzBeV6csf1kcl55z0iWFo7Gu9iToJRtYjtwbycbVvuE=;
        b=Q2RKMhGe+OZKDBjBS86tSDFZwmAWtE6WuE/NpBgME9Agtcjdh05fD5X9XyTiuSTJ57
         i7TBE/9hJQXZe4cKhGMVqdhrAqBck3Op3eU8wI5vJDTIzI7KwqvwX4hgkv9NVRmELdUR
         ilhovadqdYIcB64Sn+L+pnutl68TssGuNkCewqq+UFI0ENN+XNqhSBHOnBF1rJ6vNsHQ
         qRFk3uN5tbzwcNfnF0wIMZzkRgRkG8221HchyrevXXQHwH5FjoR49cWg1/A4fBh+v+G+
         cFNkjtZ1tjmZK8rdp+UAwZzhLia3mndiQL9nf5YfZu3lnGeDqjlg2xxYdSqxr556y5sh
         cspw==
X-Gm-Message-State: AOAM532UG+krJhbJUYOT0Ij+5D5FpWblzD0mheCjW4nTOTk6w4po5vGS
        Rl8uuRkWK5sqmogpGBP4MI8gOLWKQJU=
X-Google-Smtp-Source: ABdhPJzatLbUT8+uZsyfEUeHBUxfvsefzR3hVLPkBpUTLRPXlHrEt7+ds9tKchrpGi9VnNX0rCeP7A==
X-Received: by 2002:a17:902:b7c1:b0:15b:3c09:3ed3 with SMTP id v1-20020a170902b7c100b0015b3c093ed3mr27484380plz.73.1651051725863;
        Wed, 27 Apr 2022 02:28:45 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm18221292pfv.123.2022.04.27.02.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 02:28:45 -0700 (PDT)
Message-ID: <64e105a5-50be-23f2-6cae-903a2ea98e18@gmail.com>
Date:   Wed, 27 Apr 2022 18:28:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: submitting-patches: Fix crossref to 'The canonical
 patch format'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference to `explicit_in_reply_to` is pointless as when the
reference was added in the form of "#15" [1], Section 15) was "The
canonical patch format".
The reference of "#15" had not been properly updated in a couple of
reorganizations during the plain-text SubmittingPatches era.

Fix it by using `the_canonical_patch_format`.

[1]: 2ae19acaa50a ("Documentation: Add "how to write a good patch summary" to SubmittingPatches")

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Fixes: 5903019b2a5e ("Documentation/SubmittingPatches: convert it to ReST markup")
Fixes: 9b2c76777acc ("Documentation/SubmittingPatches: enrich the Sphinx output")
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org # v4.9+
---
 Documentation/process/submitting-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 9bb4e8c0f635..bf5ead743ccf 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -77,7 +77,7 @@ as you intend it to.
 
 The maintainer will thank you if you write your patch description in a
 form which can be easily pulled into Linux's source code management
-system, ``git``, as a "commit log".  See :ref:`explicit_in_reply_to`.
+system, ``git``, as a "commit log".  See :ref:`the_canonical_patch_format`.
 
 Solve only one problem per patch.  If your description starts to get
 long, that's a sign that you probably need to split up your patch.

base-commit: f5461124d59bfb62bd9e231ee64cbaf757343ad5
-- 
2.25.1

