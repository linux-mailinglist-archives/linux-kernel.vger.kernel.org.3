Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E534A89D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352787AbiBCRVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiBCRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:21:37 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0662C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:21:37 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so3633893pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=24EFpZU5AMMCntdM+3YfQ+A/kKth8PZ34wiS7rq1lOE=;
        b=ZGyDTcBC5eFc5kbinFdbfWPBrR+a2FQv5Vy9d1MpBUNDLg5e0Yt0uTkNFyZYRZi4m3
         IVuP7IC7Qk3RLqu52zHO0CY5umPdsbHseZjVRWkrcIp6r+cUIbW1sSeMPa0NSIfHmhGi
         h3Uvb7aQa4/npd9Xr5C10sPg7M8x1qM7g6RnzBDFAbLakuCOZMJlgP79DtSq4wxO2ARQ
         JrpqwhDNJpC5GsIF6RVTdmb8cUlu184PtQUiR9YKyCji34zSLekhSIXqG+HKBZga68d2
         UecaS4HVYn04hOwGrSaGypRoXPZppY07u1OwjVHHlgmZnr8ZgQdpSf5X9hMplC7MybID
         SsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=24EFpZU5AMMCntdM+3YfQ+A/kKth8PZ34wiS7rq1lOE=;
        b=pmczkYdAw2xS/K1FdlqxMJD9K+AUGkyITEzDwkB3nBeJ2cJLDCsMkJSRudu2dnJMKu
         Jo2b+1ozNZg6mhDEZCl20KTtUegCHEp4jOCtqNIimnvxc8/oh27o+3Lkq0lGKxxBddFt
         e1Cq4I+FFSw7W6WVPZl1+T6YVQckqm15H+RQjMNY3tR62maoJStrMXumJgNe/uEDopzN
         rmX+5x6zktXVyMNRU9vgO47GlFsYB8rUxK15iAFUs2TQruzfCXeaMxmhsmnOkhksD+Vr
         HQaPKKVlPT/3PdVK5WSomI/kdXasin0jqmSwcEzlLXDmaHzFMq/bmlXNOR0Y06/uusQS
         cbFQ==
X-Gm-Message-State: AOAM531E4gf7tJizeivpHKRlkanWXO+XTTWek+PFWp9IvyvTwLKUasaS
        /+ATC+8cs2LVMTezlXQHWPQoFvS+ABG3z0/RH8Y=
X-Received: by 2002:a17:903:230e:: with SMTP id d14mt32940420plh.4.1643908897292;
 Thu, 03 Feb 2022 09:21:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8e86:0:0:0:0 with HTTP; Thu, 3 Feb 2022 09:21:36
 -0800 (PST)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAGMjROeX5-miyfUzKy+K4mavQH0ofoVGwWTeF_gFcZ7nGaxuUw@mail.gmail.com>
References: <CAGMjROdbfJBaUg3+McSRKXj7mH6XD6qpLkLHenVGdZBo9Ms4ug@mail.gmail.com>
 <CAGMjROfYyesJDzL00Ly+yEfJwpSJk5VKo7npOWuQqorAvtA0ag@mail.gmail.com>
 <CAGMjROdHxorieEbCm0DXhHoJWoj02Hy7-r+jTGiLF9OZoYhn3g@mail.gmail.com>
 <CAGMjROfyO67vKU9KFckq_JSmsS=y39KK9yWD0q26zYug_fNoOg@mail.gmail.com>
 <CAGMjROfzfvJ8xeaEscACcw1jfAL2ZDdo0Sns_FHvboaFUL+dvA@mail.gmail.com>
 <CAGMjROffspibi9gVRwJBbnq+0V9+6-BEqf-26DtY7eYgMsetTw@mail.gmail.com>
 <CAGMjROcM+aqHLhGFfihECFCLAU-8BP0Qe4wL0LLMdnYZS=HVsg@mail.gmail.com>
 <CAGMjROcB28nLqD-Yc-v4XtcvK5hvnHkaKOzHD70dM+GEFmdkVQ@mail.gmail.com>
 <CAGMjROd9Ekdkqfftx7wvKnpL=HmQfjct8KGnQEbVaSc8um4yaw@mail.gmail.com>
 <CAGMjROd=sKW0yXrxV4k_JZLm1nbhKoLZKksX1oTbb-TeZb1WGA@mail.gmail.com>
 <CAGMjROeXEZcjbj=ZcuVowqA7-0hDKaBgoBbj9h_eZy2xBm+M4w@mail.gmail.com>
 <CAGMjROeZ8k91xEGh-d6J4pkn28jKDTgn3+hxGjSw_qQgdN+Zkw@mail.gmail.com>
 <CAGMjROfxeO55_0qwKnFyaSRpOJn3aaHUhz3LOPKVeVzA7sWbkA@mail.gmail.com>
 <CAGMjROfZgX7nysDqW+dPxkE3=gumhH4xOMnsOqgjYaYr0M_8Cg@mail.gmail.com>
 <CAGMjROdsB8RKVojU5E33whXc-tAYEAgV9sT9ttV8Vd3mP=27gA@mail.gmail.com>
 <CAGMjROd4n8=SFfChJv0wA3JzPLZAbF4-7i=L+FF4-KdCOT-QyQ@mail.gmail.com>
 <CAGMjROdSWOdS9VsJ7f28qunkgocURMR+x9ya6LVo0bRv1Yy0Sw@mail.gmail.com>
 <CAGMjROfxxv4Ne7wk6zFTe3OH1WPGEb8i95anORAp8Dd1tD2wbw@mail.gmail.com>
 <CAGMjROeS49yFUyogOaaGY+73BwGcs+pMpxRpe6nbgBR0fq6Y3A@mail.gmail.com>
 <CAGMjROfeuBWFHZ_ZiD8M_G=WXZPi0_RQ73WNbpjrpbUjyphFYw@mail.gmail.com>
 <CAGMjROdbXD4kZ=8i9qhko+mAVy-k-MquuKhgZE0KdKSuZOkumg@mail.gmail.com>
 <CAGMjROcuX+XybAqLYMW2xHVDGe4Hoj8iWiu3V2V1c4+mNb+xKA@mail.gmail.com>
 <CAGMjROcvva71FWA9y9wpjs+pSwDhYknF7UgKTQbQfSzzAfOEjg@mail.gmail.com>
 <CAGMjROd-W+28N_0uPSN1yb84BVpiV0MzE2X56LuL=rPkdSmoLw@mail.gmail.com>
 <CAGMjROcdQpbkgCpqtztV1njF9NM2zavYPVpQ9YGiwa_dQEy+iQ@mail.gmail.com>
 <CAGMjROe_D-ugYq6SObs2E=o6qhrwt6mysTmaxKiiEGm2VM2csg@mail.gmail.com>
 <CAGMjROfRBSDdLFde-YCH9KU3e+UbPOuSWivJL4b-1o5mQ81BaA@mail.gmail.com>
 <CAGMjROd3d8UFkVzj0APuvON5d-Uj1SOzP16hR_V8i3opnhA8_w@mail.gmail.com>
 <CAGMjROev0BVtjq2uCaR18Y4poSX4-22ysQft2LAqPT-44tKKNg@mail.gmail.com>
 <CAGMjROfcf3jH9he5Kr3apZPXD9K95_LRJEVibEpgqQuEgdPxrw@mail.gmail.com>
 <CAGMjROdqRZUB1Fb-pq4_-9iCJ+0jDmLOvbaxPz_8h3mMj9Zp2g@mail.gmail.com>
 <CAGMjROfKDNya_a36vMuW2z39N42XagMdQJxdUo1h4RymPODaig@mail.gmail.com>
 <CAGMjROepizBPo4vMQx-oRiC=e0YWnFr+e=o-dHHp_38_G6uR5Q@mail.gmail.com>
 <CAGMjROcRo7zBoxAn8gCJfQAgiKR6jDemRtsDFXva_9UMkkb-dw@mail.gmail.com>
 <CAGMjROd7E0eBdavwRchL_yZdiArJ32__s_vJeSnFN02A8h4UxQ@mail.gmail.com>
 <CAGMjROf6v=E1AGqq08F62Mh_gJW+mUuyrJpx855nnmMnqiR+HQ@mail.gmail.com>
 <CAGMjROeFQLA1kh=7y7ZH03UMdXQ4YA5N0tNhox2QnhWfw0cNYw@mail.gmail.com>
 <CAGMjROfi7BmnPyNAqniXLqs3oLPyNtCmZxBGbj4asE1T+hFJow@mail.gmail.com>
 <CAGMjROeijDU-yzk02v5468r+RRVBHmdYWDjiO4ruzbmLiO9Sog@mail.gmail.com>
 <CAGMjROc_Xg7e=tBXp4XccwsLY9bmVXWaWD+-MqALsbtDKjH2XA@mail.gmail.com>
 <CAGMjROfKiXVYc7dFJqjr-Hi77_6EzfU0+a757EB_p5PuEf4h3w@mail.gmail.com>
 <CAGMjROcTv1g7QkfhcxKiwHu80cHtT7rHQPtzyacHNcvG93HHkg@mail.gmail.com>
 <CAGMjROcKTth1nA6y0cDHfR65369GX2FGndDeanZ9GmHJMJp0UA@mail.gmail.com>
 <CAGMjROd8K+ftxS6oVbbH9Xim2oizbDfuG2MFJqaZQ=b2cCAedg@mail.gmail.com>
 <CAGMjROcBoCVZ86uSGjPN1J2WBfdG4pBBi2X4v2H8tn9Z7RT_vA@mail.gmail.com>
 <CAGMjROf0EszoqhbqnRQg8Qtv3-bMUvxeDysYX0trJa5BwD9cjA@mail.gmail.com>
 <CAGMjROeKZxAX18+NUKrrXskXYWqp6yY9_04CumX5NBMtc37DZQ@mail.gmail.com>
 <CAGMjROfpSTLbFXT4vEmuJMfxReemxiGR0G60i3X1=04U5o157Q@mail.gmail.com>
 <CAGMjROdQDBSL7SxvRm6bm_f+Q-e91oYv3QU=HbWgA3jBuUHAwQ@mail.gmail.com>
 <CAGMjROebg34H618e7hJc04Tc3xL6EwDUiU3eJ7y7FBFR31qnqg@mail.gmail.com>
 <CAGMjROdJm5RG+vzhJWSOb_99wBd-azuy7Tzy3kGYvJ3d6Nn9aw@mail.gmail.com>
 <CAGMjROd9-iidk0MbVM3hTgUqQ-u-WMEckfnTQ=JgvocK9pLR7Q@mail.gmail.com>
 <CAGMjROdjzGVho8d2sPj1vyBM5oBDonzVyzR8kbcLj-ys7KSvog@mail.gmail.com>
 <CAGMjROcexGGxQtbJD9CtV9+sjXqUtJUhT0xnm9RUgVNoBXBs2A@mail.gmail.com>
 <CAGMjROeA+a1jQvAv-sJCwkr2jH-3W7Mrx1nCmeTriHjuT95s-Q@mail.gmail.com>
 <CAGMjROf7xx73c59SaXUBLFb8tFHD44mSXk1SwQsF7r_kjOytgw@mail.gmail.com>
 <CAGMjROcFOqVPgQm1821-21n8xcPDKXSpdaejZk-Sndr-rDWqNQ@mail.gmail.com>
 <CAGMjROf_7bUkdTLNgkK1As8ExUAvX5R+tiv5tMqcw-+8aRGE8Q@mail.gmail.com>
 <CAGMjROe2_Az1Np-6+XHbJ_9QreRPrmUKF6-_F2UN4xjGQTSi+g@mail.gmail.com>
 <CAGMjROfsic-11WsOrKY=etNnNXe0+An9XraWEQ_Lqt9YP_ObnQ@mail.gmail.com>
 <CAGMjROctnuUYMuv6O2beD=EpwGNTMZ5Xqz5xRityRSWDuJV=fg@mail.gmail.com>
 <CAGMjROdCO6FVyzWF1LKwhEWwOkcH7wgwxNpASHtfDxUr56kt4A@mail.gmail.com>
 <CAGMjROcev+iutELTXx6wMkaSj=AKgSvi=mXKmF6esnToHkvmww@mail.gmail.com>
 <CAGMjROcaECsL4mB2y=f31wrRfmqNNLqhjkuJ61Xn69+t2-HZ4g@mail.gmail.com>
 <CAGMjROfv8AuML_0FfUBL7UUaVog1YLwRPtcEUpRMCPkdX4ReAQ@mail.gmail.com>
 <CAGMjROfwpUcYnuKpTkOtJwBwYrXsYW0_NHPgzbmz3LW-0tbiXg@mail.gmail.com>
 <CAGMjROcfByGKoYPXCQO7hjfN91pMgbY+wz4+Ux-zbAhPLf2JZA@mail.gmail.com>
 <CAGMjROf3-j76fxAb7aqYWVE-u+00nwU7HxOA4mv8o_BmgQ6yFw@mail.gmail.com>
 <CAGMjROfL3RvR4RU=7qW7UjUiEg8s5Vd7FKrS9g+46shj6OafKQ@mail.gmail.com>
 <CAGMjROdHkA0oTykwtP2rDj1953K5UX0ERUY=6n79VxCo+P=ikA@mail.gmail.com>
 <CAGMjROfoXgApNk9He3gff+REZ4bzpFCD6mz0nt3wXFCz6dUnPw@mail.gmail.com>
 <CAGMjROfBr_uQt2GJUh2wFHhpemc-aMkgFNYnSzCKKnC9cmuPpg@mail.gmail.com>
 <CAGMjROf61wbVgypF7ohTSgvY6mVHevZ9mu=YkVLUs709rdzpew@mail.gmail.com>
 <CAGMjROfnmvZd-iw5gLUZJsQsZLjxjDE31J4JZ+cSXi+n7YV6rg@mail.gmail.com>
 <CAGMjROcu2Y8dpppSbSbw1aGirc_pLLhkX2rDy+j04+Y=a-XQ7Q@mail.gmail.com>
 <CAGMjROeC9ektS3t+TH4p5foQ2e8-iPwRBGEA8nX2PGQa5LoCCA@mail.gmail.com>
 <CAGMjROfVLBE96pr3EpSihjpaRvsQaT4zFYtoMXagK-XWmuxs3A@mail.gmail.com>
 <CAGMjROdhcwAncM3ta02R10R23RZjuxAgGMpSgrmTj6rNnW1EHg@mail.gmail.com>
 <CAGMjROdgRLPGKt=08ViobpT-rc6XSh0fd3XRVMVaFzzo-CYszA@mail.gmail.com>
 <CAGMjROd3E1ZrXJTEiyCfe3o4ATUdB3C1ysA78f-AiqE4ydKQtA@mail.gmail.com>
 <CAGMjROfAbikPMm-FpPJcdKx6YGRbtE9kRo7OWSaKwAh-a1uA0Q@mail.gmail.com>
 <CAGMjROf_a6apRFGnP0U81io-F5LWEQ9-mAd4YtkRrcOEsWPYnA@mail.gmail.com>
 <CAGMjROeJNtrC5hzgapLwCbzb3=N1=KPrasJGbOBjF3A==J0=-Q@mail.gmail.com>
 <CAGMjROdv9cK2zL=O7DddX567SDzxGYVS3ooqcWYPNmz7Wz40uA@mail.gmail.com>
 <CAGMjROei=8YViiH4Eaakds8RiojgVmhrVN=hA8R409m8Xrp9hQ@mail.gmail.com>
 <CAGMjROcKcM69cwsgD=u0Um+Y090n3f4nmu-gk8k6imd62eoZzA@mail.gmail.com>
 <CAGMjROfXP7DVKpNN+Ozd7AojThaMODEOc8H9hZJB=cvgnuWiAg@mail.gmail.com>
 <CAGMjROf8wGMVNPfCfQWLTOHd6B+WdVyb0-QyvJ3GXU0Q9pduLQ@mail.gmail.com>
 <CAGMjROcKD84UW9rt9QL8OL9ONLmO38h3uW8-pbAUHN1jY8nddA@mail.gmail.com>
 <CAGMjROfO68LkYH3ZH=W-Pp5j61FO-2nJ6jjm_+HFs_Ev_0a1bg@mail.gmail.com>
 <CAGMjROf6ZXKHcoOXXg3z1F8ZvEvj9paWnPK_yGN5_tOJHjC1tQ@mail.gmail.com> <CAGMjROeX5-miyfUzKy+K4mavQH0ofoVGwWTeF_gFcZ7nGaxuUw@mail.gmail.com>
From:   israel barney <sylvabou2018@gmail.com>
Date:   Thu, 3 Feb 2022 18:21:36 +0100
Message-ID: <CAGMjROeczga45GJwYWL85QYsUs8a9JUg=u9AT-LBpHFQamMRww@mail.gmail.com>
Subject: Greetings
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day My Good Friend.

I am deeply sorry if I have in any manner disturbed your privacy.
Please forgive this unusual manner of contacting you, there is
absolutely going to be a great doubt and distrust in your heart in
respect for this email. There is no way for me to know whether I will
be properly understood, but it is my duty to write and reach out to
you as a person of transparency, honesty and high caliber. I'll
introduce myself once again, I am Mr. Israel Barney, from Togo Republic. I
am also the Branch Bank Manager of Biatogo Bank, I was also the
Account Manager of my late client Mrs. Anna Who might or might
not be related to you.

She traveled down to china on the 28th of December 2019 on a five
weeks business trip and after the successful transaction in china, she
flew back, not knowing she has been infected with the deadly
Coronavirus (COVID-19). And she sadly passed away on March 20th 2020.
She left the sum of $3.2 Million (Three Million, Two Hundred Thousand
United States Dollars) in our financial institute (Bank), she
specifically confided in me told me that "no one else knows about her
funds in our bank" that the funds was for a project before she passed
away while she was ill. And down here in our country at this present
day, once anyone passes away, after 1 Year if no relatives of the late
the customer doesn't come to claim the funds/assets, it'll be recycled, and
reported to the Central Bank where the greedy government will then
want to have their hands on the funds.

That's where you come in, since you bear the same surnames with her, I
want you to stand as her next of kin since no one else knows about
this funds in our bank besides me, and i don't think anyone will be
coming for it. I promise you that if you agree to assist in claiming
this funds from my Bank, we'll not bridge the law in any way because
I'll be your eyes and ears here in the Bank.

After all is settled we'll share the fund $3.2 Million 50% equally or
rather invest on whatever we choose. So I would really like to know
what you have to say in regards to my proposal.

Thanks
Mr. Israel Barney.
