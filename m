Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7AD59841B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbiHRN0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245122AbiHRN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:26:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF83FB5151
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:26:12 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so1094478otr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=Rzp7QF7DBG8UX3VH0GtIQF30AFU/7lko0NVgn7RL1ns=;
        b=N8DQwjDxCLUsV60GnV2rd1DgWuyoqluY1WiQ4ICBA7eyL1I2SEZfk7qRxqfdADImCU
         79AiML9EbBAWrwiFIwV4NZH7AFB2RH6thduAM+Knf21Z6fcserJD3hW5u49OWUkrURiE
         6YIEW7/S1nh1ODzGU3kXgJhm5Kkxa2Q607FxXnbDNauS0hC3zI59CfOjUX/O/By37OJE
         lkkPmPkUIJuX1hZ3EefzXRcPXt7uI/jso00WIDs+m33wT1vNY8D40i80bX0aH8p/2ySj
         mNpcjMrPuMUcejSn2yErEQdXJUcq8qZHqV08ce8J4nz9rv519DjH3GmcHIE7SaofofMb
         32zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Rzp7QF7DBG8UX3VH0GtIQF30AFU/7lko0NVgn7RL1ns=;
        b=GgMA9GtWVR4PEMCEQG72idexEcceSE1mtkumNzaCpDl6KvMPK27xUp2+OE68rkMKsE
         zN3QlfXcTLiz0VhEQZR0R1Ng48gW+Q6e0sRxuHwI3k/z1xMsXTsnPyuULu8ua/d24LBB
         AAgH+DTBlGMj10/cbjRK6sZA+qj1iGNJkHDBBXw9Oh8271njymq5W69601XrWCKNWXHD
         If1e1U6SR8YGwjKhFCtD3kw1JrFXhZw4Y7k9Nqzkbq+mIxH19Inq4iB/nIL0QMiCVn2I
         mGZN8bQFFiUpjBofvbr5UvC6adt+nNPxbbygTugK3brMfZh03wvLReIRuyVo/8n31vne
         YDQA==
X-Gm-Message-State: ACgBeo352exuCsxUuHxHh7Y5Hx8tRnsKYlLWbHjFXjiO7XWrT/6gGN31
        H7qtoidWqsUiqewwbPYQW5QU+FdwXG2FG3gs1Ww=
X-Google-Smtp-Source: AA6agR4IQMKF3tTYE9KA//LwUhef25Er7iAak8mfPpJ+HOrJzXwoc8p14xOFHzf9bIoad3ykIiyyxS9m/WLTRneyFDw=
X-Received: by 2002:a9d:73cf:0:b0:638:a617:98ed with SMTP id
 m15-20020a9d73cf000000b00638a61798edmr1118039otk.198.1660829171930; Thu, 18
 Aug 2022 06:26:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7213:b0:ab:a214:b610 with HTTP; Thu, 18 Aug 2022
 06:26:11 -0700 (PDT)
Reply-To: un.imftg@gmail.com
From:   UN IMF <wuoffice.net.togo@gmail.com>
Date:   Thu, 18 Aug 2022 13:26:11 +0000
Message-ID: <CAJZorP9OETkmXCK99fOg7CW34hk77Xaf7QEYAfpqwDDYo5b7+g@mail.gmail.com>
Subject: URGENTLY !!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:32a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wuoffice.net.togo[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,we  have emailed you earlier without any response from you. I've
an important information for you and it needs your urgent attention.

Best regards.
C.O UN IMF
