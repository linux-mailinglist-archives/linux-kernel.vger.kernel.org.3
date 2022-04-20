Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F6507F28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359043AbiDTC5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbiDTC5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:57:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF8387A7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:54:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q14so299145ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jxe6aaDFwdux36JQcvP6igMTeJQ+Mr5d6kdF2Kkf4S8=;
        b=MYfLCIuoxCHOSrULnmFtwpHkeCjvUOxhKXOYrDA1SlsnP3ItSzapAX+8VLEy8OXTPb
         90g0VXukdn33/poIyhXNFqrZp7HOTzyidGRE8ntshPW+As+KlzLTyPzftDQbZ04wMyXo
         r5IDbaJf7sNPaHBZLYpdJrEymryyPqXN6SpHFev+l7DyLF10mUbLpO5llXqr73UXxjPF
         BN+fawMOZ3Wbxz3NYV5OTeflMjANRNbeIq4giL7jiJAx1XDVWXn80dGJLJ+7r5YoRRKr
         /+v1I9YY8SvxXVV0uCUT9Ve7aFEElg2+/NMym74nE/b+smSSQD5yCim0Y/YPHd/WLpiE
         hxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=jxe6aaDFwdux36JQcvP6igMTeJQ+Mr5d6kdF2Kkf4S8=;
        b=ngIShkrFPSnSoXvAV6J/BXoF8zJs+bcmgJbAQ+1hBzJkcbBh2X9vPEAhMxo2jOD5jX
         SlynfcNGqI4AU1zPfhGoD7j5v63utXcNeWRkfYNOa5jBOu0iTtlbe6OCoHv+UzUq8a3I
         QAcmu/CQJWwgurlknpP+Xbku0rW3Atm9ssfJ0LsXlcjcfthBRhVbL2fzhXs7gsTHzYFx
         mCVIi748XZEP8UeRNNE9jB2G8WvxMTkU9p0Q0VvG7qbjjdvdTGpYamjr2LmqFlczrpKl
         Ucf7VrepeUDywCE8VdZVFsyEdrtZRv8pW81pPrYchwXwzU0DLF5a6GLWkVqyeoBIQ58W
         GtZw==
X-Gm-Message-State: AOAM532uJ8Mjs6Opl5Aakvypr9ShDOjjW6ienC+cWvLESa3DtDr6L5xo
        S6Ow2kA0Tlg4F6emPTB5k+N8EaGvTjAuAQMfThs=
X-Google-Smtp-Source: ABdhPJx7LC/o5uk7hGQ3rCz11a8VlwvueLWCyEAlkWqhaRvS70J9hdCcKHYIiJGhGuKVHXo5OxnNrEyW8l8ZjzPH6uQ=
X-Received: by 2002:a2e:a318:0:b0:24d:ccaf:74ae with SMTP id
 l24-20020a2ea318000000b0024dccaf74aemr2924832lje.17.1650423263860; Tue, 19
 Apr 2022 19:54:23 -0700 (PDT)
MIME-Version: 1.0
Sender: alobadodji@gmail.com
Received: by 2002:a05:651c:505:0:0:0:0 with HTTP; Tue, 19 Apr 2022 19:54:23
 -0700 (PDT)
From:   Miss Reacheal <reacheal4u@gmail.com>
Date:   Wed, 20 Apr 2022 02:54:23 +0000
X-Google-Sender-Auth: Eo09Uxre7Dsux6S1W9Dl0jPgiME
Message-ID: <CACNx-8omyMjbehuqvTmLj_ENU3hA8r_4S_v_+NSkojL_x0AiYQ@mail.gmail.com>
Subject: Re: Hi Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCueRnueni+Ww
j+WnkA0K
