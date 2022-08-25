Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9F5A0EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbiHYLJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiHYLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:09:01 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E8AE84C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:09:00 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11c9af8dd3eso24053906fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=oOSStMhPPt7WgsXykxRHVYSwvmQKmzU4l/FIBhUK54yP6Xmj5rm5GFA06sRY6M5uYe
         l5RaYpfaPZz5FgQbUe5qO/BJKwtOrCDtx77u5Fe0Foxc05ILQgKvAA3Ue+ATiHgpCy7M
         g/TMHHYr7irWsq9geuv/n3b0Y0SuS7N6l9xoPXqBRd8C7Ry07t64fRIVtdXORMQsdeme
         /eQbfuaH09v5+W4flpygivC3umnkzIeGnmDNp8/xnYcKy1otfeClrQhV227XY5nvOiLb
         lktoPOHELlmldACIftKIWqPmJAGxDH4kpTAZyxziSy7hlYe8UHj93rN6ih0v3r/r1OSD
         sPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=K82rbT4UN16199GX1w4//35BBCvZ144viIK4+sFgfIqbVC36XKb2S+jFHj5Ssw2DSn
         zFaKdqVbw4XRTTOXgjs6WWk6D8Pq1vDpWPZoGCuzWUZHEyPE4WMewAuxfC45AINYlgCC
         ajOsGany5buJs4aCcAPH0LIm8vmmrrssyiLOeoEqZxNoONQwUU0z59god3zkLWZo5Xqy
         I3quEjbktbb2ZldWN92Ue5enoVDP3Pwmn9JMuCfawVynoioO8uNHpqch1Ww3viGbjyhi
         KkwVI61UuIRp+VjTbiChu3ZMWVAjHl5jGI5lfahqPzJcoOnzwwcUwoIGn1h9jWMFb03a
         1ZBQ==
X-Gm-Message-State: ACgBeo2vaMfPW3+8FSA/WB9HTJs1J5jGmCNsErgPXzs4Kwfp4aYhK5Tv
        tZ4lq8hmYIaJ45ikCf1nYzURd574Tbuq9FthZOQ=
X-Google-Smtp-Source: AA6agR6vVIoYMnvW9L+u7jNj5fu9lnPjJgh+3hZ5jqKbgRk47mKKNsW+IHVT3XQcN8ZvMlbO2rJ9DBUKmWL9CS3rvfg=
X-Received: by 2002:a05:6870:b51f:b0:11e:39c8:cc10 with SMTP id
 v31-20020a056870b51f00b0011e39c8cc10mr361328oap.184.1661425740137; Thu, 25
 Aug 2022 04:09:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5ec3:0:0:0:0:0 with HTTP; Thu, 25 Aug 2022 04:08:59
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <tadjokes@gmail.com>
Date:   Thu, 25 Aug 2022 11:08:59 +0000
Message-ID: <CAHi6=Ka_Ok_WeqE9hPR_fLHOs8nU6YHankocsyiVyNjiPUkqkg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tadjokes[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bok draga, mogu li razgovarati s tobom, molim te?
