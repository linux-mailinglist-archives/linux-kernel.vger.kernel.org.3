Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A24B5D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiBNVon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:44:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBNVol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:44:41 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00D18207E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:44:32 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y6so50235332ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OJh1pSV7SihOCRuhd+9c4PnEUIJns5DmX9HnYqSgGac=;
        b=qgmlwYDGkoNVCY8VDKniKwVZYhn2vnhMQysmTkzKnD+Fop8dDa3tOXD/07H9Ydb/KX
         r45zgGYM+5JYFxStq/cYjXDCqp9RV06g9QgFgUZREXqUVnK+rsSofP29q6An3uZXVs2P
         DlCW89gEffSAKmzYmoUdA5xWYhnnCy2JvqFh8iEiUESk3y/hLN0SARYQNNBFuE1WpXAH
         GheKi9wQ5uuB7/VZhGwRBGPJ0GrtLgneaJ/2Q8ez6IExmkPmrBlBCjagQOgsNsthM564
         cwM+oj+YM+X/h271HVMZueHy6XCyqDYxps7UzZOLEq7H2DiYrWTNf/exPpcQvosjU+ZJ
         Ga1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OJh1pSV7SihOCRuhd+9c4PnEUIJns5DmX9HnYqSgGac=;
        b=AIqy/1LmV4h2hQE54pnT3T+Eo+PK8Ktou/wNHnWJt5E0hJZdYsqBUbTaJOpd+HaCIZ
         Zqski7WLuftrtv8swbyjs7cTz2bNPHc4T6ttkyfEwBr8NEfaQRdNBFbTyMWZdM5o/xmD
         W4RSXIEhSHMOqRj3hVus2cr9X8BoGT6PQRX75iPR3/oKokjYfwgL3A6ZQhZD/P8ZbGw3
         K9LwyTTTwcjS6L4VWa8Ydh4G1z6lSol5yhae+sfavYnmKWvcL2FStlZGFBlPpxoBVqtJ
         KP/Czoz+h6+vkuy51e5JwABSrZU8JBNO2g0d9jOxjPuLGMdEq/gXuPK7pRiDPONjc9hD
         JKsQ==
X-Gm-Message-State: AOAM530vIyabQwPzrq6Hm2BNB+/oSta3YThJB88CnGSOcSQZEE8ztlyO
        r9THPsR8TpOmYSxjN2vbE7LFFMLcL9/dddydvIk=
X-Google-Smtp-Source: ABdhPJzCIANq/Pk7wXONWKfp3mkewViHYk6Sq2ix3MhVsreoU1VbSJQIG44humsPJD6lGoNzpzjVooAhvOEms8ahKgs=
X-Received: by 2002:a81:9d8:: with SMTP id 207mr807873ywj.45.1644875071592;
 Mon, 14 Feb 2022 13:44:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:5697:b0:127:6892:b75a with HTTP; Mon, 14 Feb 2022
 13:44:31 -0800 (PST)
Reply-To: mrsoliviajorge206@gmail.com
From:   Olivia Jorge <globalmketing001@gmail.com>
Date:   Mon, 14 Feb 2022 13:44:31 -0800
Message-ID: <CAL6L2uUf69uvai00SFpCKE_ha5j=-0EasaeOXfetBYRBjv6_3g@mail.gmail.com>
Subject: If you are interested
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b31 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrsoliviajorge206[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [globalmketing001[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [globalmketing001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

-- 
Hello How are you doing today. There is an international conference
which i will be privileged to visit Africa. In my organization
(British Heart Foundation) We've been selected to attend in USA and
West Africa. I might recommend you to attend if you wish. It's not a
general conference anyways. I can give you the coordinators email so
you can go ahead and contact them if you wish as a friend. It could
have been easier for you if you were a volunteer under BHF org cos
it's a free sponsorship conference. i will see what i can do about it
if you are interested.
