Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE2584A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiG2Dz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbiG2Dzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:55:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859D3675BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:55:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q30so104818wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vI4HCnffdrDmImtIppEl6KGtFFJV3X77yRmXj9S8m88=;
        b=PB+f9OQAGmEFuJ/Dz1RvbEv/0Tfa5CvVdSbLvlL0WgFfk13NKGbMtn19JVJCWl+Ec6
         FNW0cVQuJnY+cJ0tIpTPmGX0dBiq3/aT02MYSQ8U3AQ3LB+owQKLUILMrQlnYgU++BkM
         mmhe/33Hc+8ipm0MpMrEoR470rqZlHa4dbKRayIqQ/nADjkCYQDl6MnnEMulBDcnd/Iq
         uh3jVJ+1BaSPHAXpDIxRZfooxfDDoBhBMAtK2u0QPpLUMyQGe34sbzbDULG2HWPPlcrL
         9S+RVmCkM9vayx5DbnwTrxUec5DWqRpt0pHjN9ZbyQjX2adVThBTiw1OPErYS1jCvdXZ
         2Rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vI4HCnffdrDmImtIppEl6KGtFFJV3X77yRmXj9S8m88=;
        b=t9b2Z0ibe4mdL8Dq9wooKS4Jxb9EuJuLZxt0b6F6YBalsJoZ6qg2Q6fnyCpcdzR4OR
         nb6w8kzpkfAfqMy2kSnuSglr9l6jd3kQ7phd6RJ3W/ji5D+umUAtVey2P+a714BDQ3J4
         sYT2GCK8tuC7rF2Nsx1a6Mfdp9ktQ4fPBFjn+KJmxmQqJH4wHuwC2mFKjowzrdZNh5HJ
         w9ez/SO8AejdshsZEWV/ADkOi8LhtdC89m+mI5UpWUGS7l83RXehsQ1ZnoiPD/Py9VbU
         V7uZ9emmyFnlz7pxQlfDfquywq6yfB3Wfvz5hcvVmi6T8X52zjsaXDH6HiH2l/DgXk1p
         sOhw==
X-Gm-Message-State: ACgBeo2guRG9MbPRxeCDDlZOw1bQZz4wvFjzcL9y6eDKh8rtvTi8WB8l
        8JmCkZMn6xbwziCZwlF+4RyRj5x97Uoq1j6NV7k=
X-Google-Smtp-Source: AA6agR5hRM1cPPxzWXX5QYKLgmJRKbj6DSg/HyHKCeIsicR1m2Tjv6Hzev/cSf3JjGMCEVrXwULAkpxdbj7/LWK1MSU=
X-Received: by 2002:a5d:59af:0:b0:21d:7f0c:a1ed with SMTP id
 p15-20020a5d59af000000b0021d7f0ca1edmr1053945wrr.211.1659066949751; Thu, 28
 Jul 2022 20:55:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:48c6:0:0:0:0:0 with HTTP; Thu, 28 Jul 2022 20:55:49
 -0700 (PDT)
Reply-To: joseph_anya39@yahoo.com
From:   DR JOSEPH ANYA <mrchkoffice@gmail.com>
Date:   Thu, 28 Jul 2022 15:55:49 -1200
Message-ID: <CAOLXmCtDywYt=Ww62-+U6tSVbAMnrPNZw8P4=TpAR-1WNbsVGQ@mail.gmail.com>
Subject: =?UTF-8?B?55u45LqS55CG6Kej?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:432 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [joseph_anya39[at]yahoo.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrchkoffice[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrkurLniLHnmoTmnIvlj4vvvIwNCuaIkeaYryBKb3NlcGggQW55YSDlhYjnlJ/vvIzlrqHo
rqHlkozkvJrorqHnu4/nkIYNCuS6muihjOmTtuihjOWcqOilv+mdnuOAgiDmiJHmraPlnKjogZTn
s7vmgqjkuI7miJHlkIjkvZwNCuWPquWPluWbnu+8iDM5NTAg5LiH576O5YWD77yJ55qE5oC75ZKM
44CCIOWtmOasvueUsQ0K5oiR5Lus5bey5pWF55qE5a6i5oi35LmU5rK744CCIOWwj+eahOOAgiDm
iJHlu7rorq7ljaDmgLvmlbDnmoQgNDAlDQrmiJDlip/mlLbliLDotYTph5HlkI7nu5nkvaDph5Hp
op3vvIzmiJHlkJHkvaDkv53or4ENCuivpeS6pOaYk+aYryAxMDAlIOaXoOmjjumZqeS4lOWQiOaz
leeahOOAgiDmiJHlr7vmsYLkvaDnmoQNCuWQiOS8meimgeaxgui/meS6m+i1hOmHkeS7pemBv+WF
jeiiq+ayoeaUtg0K6ZO26KGM44CCIOWbnuWkjeaIkeS6huino+abtOWkmuivpuaDheOAgg0KDQrm
iJHmnJ/lvoXmgqjnmoTntKfmgKXlm57lpI0NCg0K5q2k6Ie044CCDQrljZrlo6vjgIIg57qm55Gf
5aSrwrflronpm4XjgIINCg==
