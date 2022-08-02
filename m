Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59758827D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiHBT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiHBT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:26:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D652DC3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:26:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv3so5147923wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=dkrkBbBKoC3+PoFqP3hU0vD20tcfeRRJsOkZZ3XUo/S8MxXU1G6P7eXayGzHWfn9n8
         NL9hmvOfm6bmM3sLJyOwfIEPgZzUKBbHyZGldc4e3Wrclo9FaogvY3CbvTkBGH/RMtm9
         Tr4x+p2DtZB7kDgptfNs0AYpKCpsnQoOPAX4WdrHzbzkq68Hx8sH4ArqC6Crf9v+NyTx
         wKZHbHQhR71ylsZ2MAZShJKsWN+X/z0a4hCIIWgr0r6EuDbRooS+j/RRwh+79y7+ID9H
         8XysGsxXmj8uoD53iMJI7KRI8ohZ182F4jeXb58bYsFVQhiYvKx+lWUBWnCxQ/qa0/hQ
         V7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=D4ufVkvdAw4GhLEJ9crHfgKs2Uyg5ffEDF+LGSZQdRoHtRTckaSt01DbHTLrfw6/kS
         vcRY8Y6rOsXMEcBkqVTTSnRn9shz3pijIZeRskI8MspioT6QaIqfXOVpuhTo6zDH1ub3
         pQyt/BcRVPypNUYp7V/gwPc6/HRqiNcKE4cULj56rU0mEKw1ca6KvvZ3aJToSdaEQlR1
         XTLUdP5Jn5W3BU9p5scSr436tGotUm6DBT27pQi7EXQWGlFjwgUpPSwdVzoFvY2ay9Ov
         R+sAFH8SuKdMyDOeQenni/rzjSIUwz4Sm40rxLOM51v2dJWiXoordARepxE/s/AQIBHA
         NozQ==
X-Gm-Message-State: ACgBeo1umtcsMYK+Ls8u5I3Z/ms5siAFFq/8HUt6BJYAgqzlf1e8JCv/
        jiWd+27p3n9yRt5Er3wKUXbdB+3jwlzqEkRmfbk=
X-Google-Smtp-Source: AA6agR5TBxpXHT7EpPjr3B0WtXj0voQO9SYrcriDZuDPCVMzJ4RCjFZbbF1xi2RE0vkDpduSEesL7HuzsLCUCb48ul0=
X-Received: by 2002:a05:6000:1c11:b0:21f:5abc:e777 with SMTP id
 ba17-20020a0560001c1100b0021f5abce777mr10629582wrb.221.1659468407472; Tue, 02
 Aug 2022 12:26:47 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kristalinageorgieva5503@gmail.com
Sender: group511930service@gmail.com
Received: by 2002:a5d:6e8b:0:0:0:0:0 with HTTP; Tue, 2 Aug 2022 12:26:46 -0700 (PDT)
From:   Kristalina Georgieva <kristalinageorgieva5503@gmail.com>
Date:   Tue, 2 Aug 2022 19:26:46 +0000
X-Google-Sender-Auth: 49WITtOwH_z0gd2oQNY42Iied3o
Message-ID: <CAOx31BO4i8=05axpP-V+EtSxOW4hgF0rJoa01MczyFPiR3GUEA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
