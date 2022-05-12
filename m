Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0845B52490C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347965AbiELJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiELJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:35:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A245A69B6B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:35:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so5522082edx.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=B9r6p7EN07mDvhfVo0cLbZ8Pxn1tf5RBuT3NfjO0k5U=;
        b=gIAzvAdCgrBKbGDbVeZ9nd+GHGFktf20DnhI7aWA0QSF4/sqIogAy14FjIFzzce66W
         JO2ZtVIfAP+ZhT/vSttTG1Xei6irUJ0IEg8k9ImhvqbmGPWy/uAPoa+bPrjKY/+xUEJB
         6pYmelbGUqDuoVzxbmeAi1Oj4SXnHvOH96ManO3X7YqiaJFOzhTBVczvSXknJWE/iO+R
         WVdaB/FAYU2x9u1fjnGCQou32q3Kp8KiSASwM85tjjDPKJq9+8RtNBKiPdx7/bFQnlkM
         a8HhGKyfV3yC43POFDVgQPgUcVLNW1toxd9S147DZ2Nl2eCHq9hnTiqSq6HzSYXIBXmM
         lohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=B9r6p7EN07mDvhfVo0cLbZ8Pxn1tf5RBuT3NfjO0k5U=;
        b=fVJKHXTpk1F9BwCkUksqGIpAK1ijsWMzlZfQPSmK1yv+B/95Xg/ivyQdTZSkH7g+eA
         PaKuwANUeIbDe8rYXyNPG+JOUJ/3Xn8AZVIlZCM9TgOBIOPo7MIwTaHJBKUoSwqvgFf4
         CmITjgzqoKSq28b5c3c2WZjxRqlglERoCQF8Tn2siph60l1aW507EsJxcUrbB20NnfaP
         HcO9wcHb3R/FXZedCSFnI1YGD5H3MaZtB5qBW2jFikJ3zLMxSnOEZkAM7jmzLF1Wq6Cw
         xbsskE7DehRxusCpWDhdo+pfc0u7furCy4HKUDwoXlFqMn0PuIq1JlyH6sbrXgrPpnNv
         d3Xw==
X-Gm-Message-State: AOAM533VTG7gKSLlIsUHIN3TruHgrKHaYhgXiMDqueCEilRbtqMV7ZRp
        AsE4IroQpNWs/gGT+LFR8JzJL9UF4tqxDhazzaw=
X-Google-Smtp-Source: ABdhPJyAPzARzT0IQ8zYSPkPwpFiKIGFpb5ZrN+uMTZPO4a6xFk3KvKaK/Tsf+UthCA1Ruu3fUBrtGHR42YfUGfeJ0k=
X-Received: by 2002:a05:6402:206b:b0:42a:3622:af50 with SMTP id
 bd11-20020a056402206b00b0042a3622af50mr3107675edb.236.1652348127029; Thu, 12
 May 2022 02:35:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:ca19:b0:1b:d6eb:5402 with HTTP; Thu, 12 May 2022
 02:35:26 -0700 (PDT)
Reply-To: sj7373313@gmail.com
From:   "Mis.Sandra Johnson." <bassiroualfs742@gmail.com>
Date:   Thu, 12 May 2022 10:35:26 +0100
Message-ID: <CAMqHDfh9MgjP6M7Ra+RhrCHCq0r049BB78F3XxyQGvCwNNcZCA@mail.gmail.com>
Subject: Sandra J.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5231]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bassiroualfs742[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bassiroualfs742[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sj7373313[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Sandra J.
